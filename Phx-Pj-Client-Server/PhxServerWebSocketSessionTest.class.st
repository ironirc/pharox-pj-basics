Class {
	#name : 'PhxServerWebSocketSessionTest',
	#superclass : 'TestCase',
	#category : 'Phx-Pj-Client-Server-server-side-tests',
	#package : 'Phx-Pj-Client-Server',
	#tag : 'server-side-tests'
}

{ #category : 'tests' }
PhxServerWebSocketSessionTest >> testHandleErrorsWhileWhenDisconnectedDoesNotError [
	| handler session |
	handler := PhxServerWebSocketHandler new.
	session := PhxServerWebSocketSession new.
	session webSocket: nil.
	self shouldnt: [
		handler
			handleErrorsWhile: [ Error signal: 'boom' ]
			forWebSocketSession: session
			incomingEnvelope: nil ] raise: Error
]

{ #category : 'tests' }
PhxServerWebSocketSessionTest >> testSendEnvelopeWhenWebSocketNilDoesNotError [
	| session env result |
	session := PhxServerWebSocketSession new.
	session webSocket: nil.
	env := PhxSpaResponse new
		type: #success;
		message: 'recorded';
		wrapInEnvelope.
	self shouldnt: [ result := session sendEnvelope: env ] raise: Error.
	self assert: result isNil
]
