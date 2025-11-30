Class {
	#name : 'PhxClientWebSocketRequestContext',
	#superclass : 'PjDomController',
	#instVars : [
		'sentEnvelope',
		'receivedEnvelope',
		'wsHandler',
		'roundTripInMs'
	],
	#category : 'Phx-Pj-Client-Server-client-side',
	#package : 'Phx-Pj-Client-Server',
	#tag : 'client-side'
}

{ #category : 'accessing' }
PhxClientWebSocketRequestContext >> client [

	^self wsHandler client
]

{ #category : 'accessing' }
PhxClientWebSocketRequestContext >> msg [
	
	^ self receivedEnvelope msg
]

{ #category : 'accessing' }
PhxClientWebSocketRequestContext >> receivedEnvelope [
	^ receivedEnvelope
]

{ #category : 'accessing' }
PhxClientWebSocketRequestContext >> receivedEnvelope: anObject [
	receivedEnvelope := anObject
]

{ #category : 'accessing' }
PhxClientWebSocketRequestContext >> roundTripInMs [

	^ roundTripInMs
]

{ #category : 'accessing' }
PhxClientWebSocketRequestContext >> roundTripInMs: anObject [

	roundTripInMs := anObject
]

{ #category : 'accessing' }
PhxClientWebSocketRequestContext >> sendResponseMessage: outgoingMessage [
	"answer a request initiated by the server"

	self wsHandler
		sendMessageToServer: outgoingMessage
		inResponseToEnvelope: self receivedEnvelope
]

{ #category : 'accessing' }
PhxClientWebSocketRequestContext >> sentEnvelope [
	^ sentEnvelope
]

{ #category : 'accessing' }
PhxClientWebSocketRequestContext >> sentEnvelope: anObject [
	sentEnvelope := anObject
]

{ #category : 'accessing' }
PhxClientWebSocketRequestContext >> wsHandler [

	^ wsHandler
]

{ #category : 'accessing' }
PhxClientWebSocketRequestContext >> wsHandler: anObject [
	wsHandler := anObject
]
