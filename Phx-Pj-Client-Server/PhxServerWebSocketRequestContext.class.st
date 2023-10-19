Class {
	#name : #PhxServerWebSocketRequestContext,
	#superclass : #Object,
	#instVars : [
		'handler',
		'incomingEnvelope',
		'jwtClaims',
		'webSocketSession'
	],
	#category : #'Phx-Pj-Client-Server-server-side'
}

{ #category : #services }
PhxServerWebSocketRequestContext >> doWithMainGlorpSession: aBlock [
	""
	self handler ensuredContext doWithMainGlorpSession: aBlock
]

{ #category : #accessing }
PhxServerWebSocketRequestContext >> ensuredContext [
	^ self handler ensuredContext
]

{ #category : #services }
PhxServerWebSocketRequestContext >> handleIncomingMessage: msg [

	[
	msg respondForRequestContext: self
	"debugString := String
		streamContents: [ :ws | 
			ws << 'SS-MessageHandler: received envelope with message of type '
				<< env msg class name ].
	aWebSocket sendMessage: debugString asJsonString." ]
		on: Error
		do: [ :ex |
			('handleIncomingMessage: error => ' , ex description) crTrace. 
			self sendError: ex description.
			self halt. "convenient to halt here while developing"
			ex return ]
]

{ #category : #accessing }
PhxServerWebSocketRequestContext >> handler [
	^ handler
]

{ #category : #accessing }
PhxServerWebSocketRequestContext >> handler: anObject [
	handler := anObject
]

{ #category : #services }
PhxServerWebSocketRequestContext >> inUnitOfWorkDo: aBlock [

	""

	self doWithMainGlorpSession: [ :sess | sess inUnitOfWorkDo: aBlock ]
]

{ #category : #accessing }
PhxServerWebSocketRequestContext >> incomingEnvelope [
	^ incomingEnvelope
]

{ #category : #accessing }
PhxServerWebSocketRequestContext >> incomingEnvelope: anObject [
	incomingEnvelope := anObject
]

{ #category : #testing }
PhxServerWebSocketRequestContext >> isProduction [
	^self  ensuredContext environmentTag = 'production'.
]

{ #category : #accessing }
PhxServerWebSocketRequestContext >> jwtClaims [

	^ jwtClaims
]

{ #category : #accessing }
PhxServerWebSocketRequestContext >> jwtClaims: anObject [

	jwtClaims := anObject
]

{ #category : #services }
PhxServerWebSocketRequestContext >> sendError: aString [

	| msg |
	msg := PhxSpaResponse new.
	msg type: #error.
	msg message: aString.
	self sendResponseMessage: msg
]

{ #category : #services }
PhxServerWebSocketRequestContext >> sendMessage: outgoingMessage [

	self webSocketSession
		sendMessage: outgoingMessage
		isResponseToIncoming: nil
]

{ #category : #services }
PhxServerWebSocketRequestContext >> sendResponseMessage: outgoingMessage [

	self webSocketSession
		sendMessage: outgoingMessage
		isResponseToIncoming: self incomingEnvelope
]

{ #category : #services }
PhxServerWebSocketRequestContext >> sendSuccess: aString [

	| msg |
	msg := PhxSpaResponse new.
	msg type: #success.
	msg message: aString.
	self sendResponseMessage: msg
]

{ #category : #services }
PhxServerWebSocketRequestContext >> sendWarning: aString [

	| msg |
	msg := PhxSpaResponse new.
	msg type: #warning.
	msg message: aString.
	self sendResponseMessage: msg
]

{ #category : #services }
PhxServerWebSocketRequestContext >> translator [
	^ self ensuredContext translator
]

{ #category : #accessing }
PhxServerWebSocketRequestContext >> webSocket [
	^self webSocketSession webSocket
]

{ #category : #accessing }
PhxServerWebSocketRequestContext >> webSocketSession [

	^ webSocketSession
]

{ #category : #accessing }
PhxServerWebSocketRequestContext >> webSocketSession: anObject [

	webSocketSession := anObject
]
