Class {
	#name : #PhxClientWebSocketRequestContext,
	#superclass : #PjDomController,
	#instVars : [
		'sentEnvelope',
		'receivedEnvelope',
		'wsHandler'
	],
	#category : #'Phx-Pj-Client-Server-client-side'
}

{ #category : #accessing }
PhxClientWebSocketRequestContext >> msg [
	
	^ self receivedEnvelope msg
]

{ #category : #accessing }
PhxClientWebSocketRequestContext >> receivedEnvelope [
	^ receivedEnvelope
]

{ #category : #accessing }
PhxClientWebSocketRequestContext >> receivedEnvelope: anObject [
	receivedEnvelope := anObject
]

{ #category : #accessing }
PhxClientWebSocketRequestContext >> sendResponseMessage: outgoingMessage [

	self wsHandler
		sendMessageToServer: outgoingMessage
		onResponseDo: nil
		isResponseToIncomingEnvelope: self receivedEnvelope
]

{ #category : #accessing }
PhxClientWebSocketRequestContext >> sentEnvelope [
	^ sentEnvelope
]

{ #category : #accessing }
PhxClientWebSocketRequestContext >> sentEnvelope: anObject [
	sentEnvelope := anObject
]

{ #category : #accessing }
PhxClientWebSocketRequestContext >> wsHandler [

	^ wsHandler
]

{ #category : #accessing }
PhxClientWebSocketRequestContext >> wsHandler: anObject [
	wsHandler := anObject
]
