Class {
	#name : 'PhxServerWebSocketRequestContext',
	#superclass : 'Object',
	#instVars : [
		'handler',
		'incomingEnvelope',
		'jwtClaims',
		'webSocketSession',
		'appContext'
	],
	#classVars : [
		'HaltOnIncomingMessageError'
	],
	#category : 'Phx-Pj-Client-Server-server-side',
	#package : 'Phx-Pj-Client-Server',
	#tag : 'server-side'
}

{ #category : 'debugging' }
PhxServerWebSocketRequestContext class >> haltOnIncomingMessageError [
	"Opt-in: when true, halt in handleIncomingMessage: on Error. Default false.
	Holds the request-session pool slot until the debugger continues — see PHX_SPA_REQUEST_SESSION_POOL.md.
	Playground / Phx world menu: haltOnIncomingMessageError: true / false."

	^ HaltOnIncomingMessageError ifNil: [ false ]
]

{ #category : 'debugging' }
PhxServerWebSocketRequestContext class >> haltOnIncomingMessageError: aBoolean [
	"Playground: PhxServerWebSocketRequestContext haltOnIncomingMessageError: true."

	HaltOnIncomingMessageError := aBoolean
]

{ #category : 'accessing' }
PhxServerWebSocketRequestContext >> appContext [
	^ appContext
]

{ #category : 'accessing' }
PhxServerWebSocketRequestContext >> appContext: anObject [
	appContext := anObject
]

{ #category : 'services' }
PhxServerWebSocketRequestContext >> doWithMainGlorpSession: aBlock [

	self ensuredContext doWithMainGlorpSession: aBlock
]

{ #category : 'accessing' }
PhxServerWebSocketRequestContext >> ensuredContext [
	appContext ifNotNil: [ ^ appContext ].
	^ self handler ensuredContext
]

{ #category : 'actions' }
PhxServerWebSocketRequestContext >> handleIncomingMessage: msg [

	('Received ' , msg class name) crTrace.
	[
		msg respondForRequestContext: self
		"('PhxServerWebSocketRequestContext>>#handleIncomingMessage: - Post respondForRequestContext: ' , msg class name) crTrace."
		"debugString := String
		streamContents: [ :ws | 
			ws << 'SS-MessageHandler: received envelope with message of type '
				<< env msg class name ].
	aWebSocket sendMessage: debugString asJsonString." ]
		on: Error
		do: [ :ex |
				self class haltOnIncomingMessageError ifTrue: [ self halt ].
				('handleIncomingMessage: error => ' , ex description) crTrace.
				self sendError: ex description.
				"Do not leave halt on: the request-session pool slot is held until this handler returns. Toggle via Phx world menu / haltOnIncomingMessageError:."
				ex return ]
]

{ #category : 'accessing' }
PhxServerWebSocketRequestContext >> handler [
	^ handler
]

{ #category : 'accessing' }
PhxServerWebSocketRequestContext >> handler: anObject [
	handler := anObject
]

{ #category : 'services' }
PhxServerWebSocketRequestContext >> inUnitOfWorkDo: aBlock [

	self doWithMainGlorpSession: [ :sess | sess inUnitOfWorkDo: aBlock ]
]

{ #category : 'accessing' }
PhxServerWebSocketRequestContext >> incomingEnvelope [
	^ incomingEnvelope
]

{ #category : 'accessing' }
PhxServerWebSocketRequestContext >> incomingEnvelope: anObject [
	incomingEnvelope := anObject
]

{ #category : 'testing' }
PhxServerWebSocketRequestContext >> isProduction [

	^ self ensuredContext environmentTag = 'production'
]

{ #category : 'accessing' }
PhxServerWebSocketRequestContext >> jwtClaims [

	^ jwtClaims
]

{ #category : 'accessing' }
PhxServerWebSocketRequestContext >> jwtClaims: anObject [

	jwtClaims := anObject
]

{ #category : 'services' }
PhxServerWebSocketRequestContext >> sendError: aString [

	| msg |
	msg := PhxSpaResponse new.
	msg type: #error.
	msg message: aString.
	self sendResponseMessage: msg
]

{ #category : 'services' }
PhxServerWebSocketRequestContext >> sendMessage: outgoingMessage [

	self webSocketSession
		sendMessage: outgoingMessage
		inResponseToIncoming: nil
]

{ #category : 'services' }
PhxServerWebSocketRequestContext >> sendResponseMessage: outgoingMessage [

	self webSocketSession
		sendMessage: outgoingMessage
		inResponseToIncoming: self incomingEnvelope
]

{ #category : 'services' }
PhxServerWebSocketRequestContext >> sendSuccess: aString [

	| msg |
	msg := PhxSpaResponse new.
	msg type: #success.
	msg message: aString.
	self sendResponseMessage: msg
]

{ #category : 'services' }
PhxServerWebSocketRequestContext >> sendWarning: aString [

	| msg |
	msg := PhxSpaResponse new.
	msg type: #warning.
	msg message: aString.
	self sendResponseMessage: msg
]

{ #category : 'services' }
PhxServerWebSocketRequestContext >> translator [
	^ self ensuredContext translator
]

{ #category : 'accessing' }
PhxServerWebSocketRequestContext >> webSocket [
	^self webSocketSession webSocket
]

{ #category : 'accessing' }
PhxServerWebSocketRequestContext >> webSocketSession [

	^ webSocketSession
]

{ #category : 'accessing' }
PhxServerWebSocketRequestContext >> webSocketSession: anObject [

	webSocketSession := anObject
]
