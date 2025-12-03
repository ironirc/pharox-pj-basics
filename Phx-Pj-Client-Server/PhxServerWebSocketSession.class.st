Class {
	#name : 'PhxServerWebSocketSession',
	#superclass : 'Object',
	#instVars : [
		'sessionId',
		'startedAt',
		'lastUsedAt',
		'webSocket',
		'properties',
		'monitor',
		'sentEnvelopesWaitingForResponse',
		'context'
	],
	#category : 'Phx-Pj-Client-Server-server-side',
	#package : 'Phx-Pj-Client-Server',
	#tag : 'server-side'
}

{ #category : 'accessing' }
PhxServerWebSocketSession >> checkAccessToken: jwtString [

	^ self context
		  ifNil: [ #(  ) ]
		  ifNotNil: [ :ctx | ctx checkAccessToken: jwtString ]
]

{ #category : 'accessing' }
PhxServerWebSocketSession >> checkAccessTokenOfEnvelope: env [
	^[ self checkAccessToken: env jwt ]
		on: Error
		do: [ :ex | 
			self
				error: 'Your access token seems to be invalid (' , ex messageText , ')' ]
]

{ #category : 'accessing' }
PhxServerWebSocketSession >> context [

	^ context
]

{ #category : 'accessing' }
PhxServerWebSocketSession >> context: anObject [

	context := anObject
]

{ #category : 'public' }
PhxServerWebSocketSession >> handleIncomingEnvelope: env fromHandler: wsh [

	| rc |
	self setLastUsedToNow.
	self sessionId
		ifNil: [ self sessionId: env senderId ]
		ifNotNil: [ :sid |
			sid = env senderId ifFalse: [
				self error: 'illegal to change session id on a PhxServerWebSocketSession' ] ].
	env respToMsgId ifNotNil: [ :id |
		monitor critical: [
			sentEnvelopesWaitingForResponse
				detect: [ :sentEnv | sentEnv awaitingMessageId = id ]
				ifFound: [ :sentEnv |
					sentEnv responseEnvelope: env.
					sentEnvelopesWaitingForResponse remove: sentEnv.
					monitor signal.
					^ self ]
				ifNone: [
					self error: 'corresponding "envelope waiting response" not found'.
					^ self ] ] ].
	rc := PhxServerWebSocketRequestContext new.
	rc webSocketSession: self.
	rc handler: wsh.
	rc incomingEnvelope: env.
	rc jwtClaims: (self checkAccessTokenOfEnvelope: env).
	wsh context ifNotNil: [ :c | c prepareForNewRequest ].
	rc handleIncomingMessage: env msg
]

{ #category : 'initialize-release' }
PhxServerWebSocketSession >> initialize [

	super initialize.
	startedAt := DateAndTime now asUTC.
	monitor := Monitor new.
	sentEnvelopesWaitingForResponse := OrderedCollection new. 
]

{ #category : 'testing' }
PhxServerWebSocketSession >> isConnected [

	^ self webSocket ifNil: [ false ] ifNotNil: [ :ws | ws isConnected ]
]

{ #category : 'accessing' }
PhxServerWebSocketSession >> lastUsedAt [
	^ lastUsedAt
]

{ #category : 'accessing' }
PhxServerWebSocketSession >> lastUsedAt: anObject [
	lastUsedAt := anObject
]

{ #category : 'accessing' }
PhxServerWebSocketSession >> properties [

	properties ifNil: [ properties := Dictionary new ].
	^ properties
]

{ #category : 'accessing' }
PhxServerWebSocketSession >> propertyAt: key [

	^self properties at: key
]

{ #category : 'accessing' }
PhxServerWebSocketSession >> propertyAt: key ifAbsent: ifAbsentBlock [

	^self properties at: key ifAbsent: ifAbsentBlock
]

{ #category : 'accessing' }
PhxServerWebSocketSession >> propertyAt: key ifAbsentPut: aBlock [

	^ self properties
		  at: key
		  ifAbsent: [ self propertyAt: key put: aBlock value ]
]

{ #category : 'accessing' }
PhxServerWebSocketSession >> propertyAt: key put: object [

	self properties at: key put: object.
	^object
]

{ #category : 'ad hoc dev' }
PhxServerWebSocketSession >> reportToTranscript [
	Transcript
		show:
			(String
				streamContents: [ :ws | 
					ws << 'SessionId: '.
					ws << (self sessionId ifNil: [ 'nil' ]).
					ws space.
					ws << 'LastUsed: '.
					ws
						<<
							(self lastUsedAt
								ifNil: [ 'nil' ]
								ifNotNil: [ :ts |  ts asLocal asString ]).
					ws space.
					ws << 'Connected: '.
					ws
						<<
							(self webSocket
								ifNil: [ 'nil' ]
								ifNotNil: [ self webSocket isConnected asString ]) ])
]

{ #category : 'accessing' }
PhxServerWebSocketSession >> sendEnvelope: anEnvelope [

	anEnvelope senderId: 'server'. "might need refining"
	self webSocket isConnected ifFalse: [
		^ self error: 'websocket not connected' ].

	anEnvelope msg expectsResponseFromClient
		ifTrue: [
				| sentEnv |
				sentEnv := PhxEnvelopeWaitingForResponse new.
				sentEnv sentEnvelope: anEnvelope.
				sentEnvelopesWaitingForResponse add: sentEnv.
				[
					"('Sending request' , anEnvelope msg class name) crTrace."
					self sendRawMessageOverSocket: anEnvelope asPhxJsonString ] fork.
				"'waiting for response...' crTrace. "
				monitor critical: [
						monitor
							waitUntil: [ sentEnv responseEnvelope notNil ]
							maxMilliseconds: 500 "check every 1000 ms. Does not raise time out error (still to be implemented)!!!" ].
				sentEnv responseEnvelope
					ifNil: [
							self error: 'timeout while waiting for response'.
							^ nil ]
					ifNotNil: [ :recvdEnv | ^ recvdEnv ] ]
		ifFalse: [
				"('Sending response' , anEnvelope msg class name) crTrace."
				self sendRawMessageOverSocket: anEnvelope asPhxJsonString ].
	^ nil
]

{ #category : 'public' }
PhxServerWebSocketSession >> sendEnvelope: outgoingEnvelope inResponseToIncoming: anIncomingEnvelope [

	anIncomingEnvelope ifNotNil: [
		outgoingEnvelope respToMsgId: anIncomingEnvelope msg id ].
	^ self sendEnvelope: outgoingEnvelope
]

{ #category : 'public' }
PhxServerWebSocketSession >> sendMessage: outgoingMessage [
	^self sendMessage: outgoingMessage inResponseToIncoming: nil 
]

{ #category : 'public' }
PhxServerWebSocketSession >> sendMessage: outgoingMessage inResponseToIncoming: anIncomingEnvelope [

	^ self
		  sendEnvelope: outgoingMessage wrapInEnvelope
		  inResponseToIncoming: anIncomingEnvelope
]

{ #category : 'public' }
PhxServerWebSocketSession >> sendRawMessageChunkedOverSocket_NotUsed: stringOrByteArray [

	| rs frames |
	rs := stringOrByteArray readStream.
	frames := OrderedCollection new.
	[
		| chunk |
		chunk := rs next: 65536.
		frames add: chunk.
		rs atEnd ] whileFalse.
	self webSocket sendTextFrames: frames
]

{ #category : 'public' }
PhxServerWebSocketSession >> sendRawMessageOverSocket: stringOrByteArray [

	self webSocket sendMessage: stringOrByteArray.
	stringOrByteArray size <= 65536 ifTrue: [ ^ self ].
	"following hack needed on Mac. After sending large message on Mac, incoming messages have to wait on some sort of timeout"
	self webSocket stream isDataAvailable ifTrue: [
		self webSocket stream peek ]
]

{ #category : 'accessing' }
PhxServerWebSocketSession >> sessionId [
	^ sessionId
]

{ #category : 'accessing' }
PhxServerWebSocketSession >> sessionId: anObject [
	"until now filled with senderId = clientId "

	sessionId := anObject
]

{ #category : 'public' }
PhxServerWebSocketSession >> setLastUsedToNow [
	lastUsedAt := DateAndTime now asUTC
]

{ #category : 'accessing' }
PhxServerWebSocketSession >> startedAt [
	^ startedAt
]

{ #category : 'accessing' }
PhxServerWebSocketSession >> startedAt: anObject [
	startedAt := anObject
]

{ #category : 'accessing' }
PhxServerWebSocketSession >> webSocket [
	^ webSocket
]

{ #category : 'accessing' }
PhxServerWebSocketSession >> webSocket: anObject [
	webSocket := anObject
]
