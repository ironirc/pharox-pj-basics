Class {
	#name : #PhxClientWebSocketHandler,
	#superclass : #PjDomController,
	#traits : 'PhxPjPromiseTrait + PhxPjLoggingTrait + PhxPubSubTrait',
	#classTraits : 'PhxPjPromiseTrait classTrait + PhxPjLoggingTrait classTrait + PhxPubSubTrait classTrait',
	#instVars : [
		'webSocket',
		'continuations',
		'webSocketUrl',
		'tokenProvider',
		'client'
	],
	#category : #'Phx-Pj-Client-Server-client-side'
}

{ #category : #accessing }
PhxClientWebSocketHandler >> client [

	^ client
]

{ #category : #accessing }
PhxClientWebSocketHandler >> client: anObject [

	client := anObject
]

{ #category : #accessing }
PhxClientWebSocketHandler >> clientId [

	^ self client ifNotNil: [ :c | c class clientId ]
]

{ #category : #'initialize-release' }
PhxClientWebSocketHandler >> initialize [

	super initialize.
	continuations := OrderedCollection new.
	self initializePubSubTrait
]

{ #category : #'server messaging' }
PhxClientWebSocketHandler >> onWebSocketClose: event [

	self logSelfAndAll: { 
			'onWebSocketClose:'.
			event }.
	"self shouldAutoReconnect ifTrue: ["
	globalThis 
		setTimeout: [ 
			self logSelfAndAll: { 
					'onWebSocketClose:'.
					event.
					'Attempt to re-open' }.
			self setupConnectionWithServer ]
		ms: 2000 "]"
]

{ #category : #'server messaging' }
PhxClientWebSocketHandler >> onWebSocketError: event [
	self
		logSelfAndAll:
			{'onWebSocketError:'.
			event}
]

{ #category : #accessing }
PhxClientWebSocketHandler >> onWebSocketMessage: event [

	| env envWithCont rc |
	self logAll: { 
			'receive'.
			event data }.
	env := PhxJsonReader readFromString: event data.
	"	self logSelfAndAll: { 
			'onWebSocketMessage:'.
			env }."

	envWithCont := self takeEnvelopeWithContinuationFromQueue:
		               env respToMsgId.
	rc := PhxClientWebSocketRequestContext new.
	rc receivedEnvelope: env.
	rc wsHandler: self.
	envWithCont ifNotNil: [ 
		rc sentEnvelope: envWithCont envelope.
		envWithCont continuationBlock ifNotNil: [ :cb | "a prior sent envelope, being answered" 
			cb value: rc ] ].
	"moreover, any incoming message gets a chance to do something"
	env msg executeInResponseContext: rc
]

{ #category : #'server messaging' }
PhxClientWebSocketHandler >> onWebSocketOpen: event [
	self
		logSelfAndAll:
			{'onWebSocketOpen:'.
			event.
			'Websocket has been opened.'}.
]

{ #category : #'server messaging' }
PhxClientWebSocketHandler >> promiseAccessToken [

	^ self tokenProvider
		  ifNil: [ self promiseResolve: nil ]
		  ifNotNil: [ :tp | tp promiseAccessToken ]
]

{ #category : #'server messaging' }
PhxClientWebSocketHandler >> promiseResponseFor: aMessage [

	^ self promise: [ :resolve :reject | 
		  self
			  sendMessageToServer: aMessage
			  onResponseDo: [ :rc | 
				  self logAll: { 
						  'onResponseDo:'.
						  rc }.
				  resolve value: rc
				  "TODO 2022-08-25 detect error of the call, and reject?" ]
			  isResponseToIncomingEnvelope: nil ]
]

{ #category : #'server messaging' }
PhxClientWebSocketHandler >> sendMessageToServer: aMessage [

	self
		sendMessageToServer: aMessage
		onResponseDo: nil
		isResponseToIncomingEnvelope: nil
]

{ #category : #'server messaging' }
PhxClientWebSocketHandler >> sendMessageToServer: aMessage onResponseDo: aBlock isResponseToIncomingEnvelope: incomingEnvelope [

	| env |
	self promiseAccessToken then: [ :aJwt |
		env := aMessage wrapInEnvelope.
		incomingEnvelope ifNotNil: [
			env respToMsgId: incomingEnvelope msg id ].
		env senderId: self clientId.
		env jwt: aJwt.


		aBlock ifNotNil: [
			continuations add:
				(PhxEnvelopeWithContinuation
					 envelope: env
					 continuationBlock: aBlock) ].
		"self logSelfAndAll: {
				'sendMessageToServer:'.
				aMessage.
				'expectsResponse:'.
				aBlock notNil.
				'isResponseTo:'.
				(incomingEnvelope ifNotNil: [ incomingEnvelope msg id ]) }."
		self sendStringThroughWebsocket: env asPhxJsonString ]
]

{ #category : #'server messaging' }
PhxClientWebSocketHandler >> sendStringThroughWebsocket: aString [

	webSocket readyState == globalThis WebSocket OPEN ifFalse: [
		self logSelfAndAll: {
				'sendStringThroughWebsocket:'.
				aString.
				'SOCKET NOT OPEN' }.
		^ self ].
	"	self logSelfAndAll: { 
			'sendStringThroughWebsocket:'.
			aString }."
	self logAll: {
			'send'.
			aString }.
	webSocket send: aString
]

{ #category : #'server messaging' }
PhxClientWebSocketHandler >> setupConnectionWithServer [

	self emitEvent: PhxPseWebSocketConnecting new.
	webSocket := WebSocket new: self webSocketUrl.
	self logSelfAndAll: { 
			'setupConnectionWithServer'.
			webSocket }.
	webSocket at: 'onopen' put: [ :event | 
		self onWebSocketOpen: event.
		self logSelfAndAll: { 'setupConnectionWithServer'.
		'NOW OPEN' }.
		self emitEvent: (PhxPseWebSocketOpened newWith: event) ].
	webSocket at: 'onmessage' put: [ :event | 
		self onWebSocketMessage: event.
		self emitEvent: (PhxPseWebSocketMessageReceived newWith: event) ].
	webSocket at: 'onclose' put: [ :event | 
		self onWebSocketClose: event.
		self emitEvent: (PhxPseWebSocketClosed newWith: event) ].
	webSocket at: 'onerror' put: [ :event | 
		self onWebSocketError: event.
		self emitEvent: (PhxPseWebSocketErrorOccurred newWith: event) ]
]

{ #category : #'server messaging' }
PhxClientWebSocketHandler >> takeEnvelopeWithContinuationFromQueue: msgId [

	| envWithCont |
	envWithCont := continuations
		               detect: [ :each | each envelope msg id = msgId ]
		               ifNone: [ nil ].
	envWithCont ifNotNil: [
		console log: 'removed envWithCont ' with: envWithCont.
		continuations remove: envWithCont ].
	^ envWithCont
]

{ #category : #accessing }
PhxClientWebSocketHandler >> tokenProvider [

	^ tokenProvider
]

{ #category : #accessing }
PhxClientWebSocketHandler >> tokenProvider: anObject [

	tokenProvider := anObject
]

{ #category : #'server messaging' }
PhxClientWebSocketHandler >> webSocketUrl [

	^ webSocketUrl
]

{ #category : #accessing }
PhxClientWebSocketHandler >> webSocketUrl: anObject [

	webSocketUrl := anObject
]
