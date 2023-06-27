Class {
	#name : #PhxEnvelopeWaitingForResponse,
	#superclass : #Object,
	#instVars : [
		'sentEnvelope',
		'responseEnvelope'
	],
	#category : #'Phx-Pj-Client-Server-shared'
}

{ #category : #'as yet unclassified' }
PhxEnvelopeWaitingForResponse >> awaitingMessageId [

	^ sentEnvelope msg id
]

{ #category : #accessing }
PhxEnvelopeWaitingForResponse >> responseEnvelope [

	^ responseEnvelope
]

{ #category : #accessing }
PhxEnvelopeWaitingForResponse >> responseEnvelope: anObject [

	responseEnvelope := anObject
]

{ #category : #accessing }
PhxEnvelopeWaitingForResponse >> sentEnvelope [

	^ sentEnvelope
]

{ #category : #accessing }
PhxEnvelopeWaitingForResponse >> sentEnvelope: anObject [

	sentEnvelope := anObject
]
