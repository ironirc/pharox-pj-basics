Class {
	#name : 'PhxEnvelopeWaitingForResponse',
	#superclass : 'Object',
	#instVars : [
		'sentEnvelope',
		'responseEnvelope'
	],
	#category : 'Phx-Pj-Client-Server-server-side',
	#package : 'Phx-Pj-Client-Server',
	#tag : 'server-side'
}

{ #category : 'as yet unclassified' }
PhxEnvelopeWaitingForResponse >> awaitingMessageId [

	^ sentEnvelope msg id
]

{ #category : 'accessing' }
PhxEnvelopeWaitingForResponse >> responseEnvelope [

	^ responseEnvelope
]

{ #category : 'accessing' }
PhxEnvelopeWaitingForResponse >> responseEnvelope: anObject [

	responseEnvelope := anObject
]

{ #category : 'accessing' }
PhxEnvelopeWaitingForResponse >> sentEnvelope [

	^ sentEnvelope
]

{ #category : 'accessing' }
PhxEnvelopeWaitingForResponse >> sentEnvelope: anObject [

	sentEnvelope := anObject
]
