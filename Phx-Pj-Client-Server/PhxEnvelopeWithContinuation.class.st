Class {
	#name : #PhxEnvelopeWithContinuation,
	#superclass : #Object,
	#instVars : [
		'envelope',
		'continuationBlock'
	],
	#category : #'Phx-Pj-Client-Server-shared'
}

{ #category : #'instance creation' }
PhxEnvelopeWithContinuation class >> envelope: anEnvelope continuationBlock: aBlock [
	^ self new
		envelope: anEnvelope;
		continuationBlock: aBlock;
		yourself
]

{ #category : #accessing }
PhxEnvelopeWithContinuation >> continuationBlock [
	^ continuationBlock
]

{ #category : #accessing }
PhxEnvelopeWithContinuation >> continuationBlock: anObject [
	continuationBlock := anObject
]

{ #category : #accessing }
PhxEnvelopeWithContinuation >> envelope [
	^ envelope
]

{ #category : #accessing }
PhxEnvelopeWithContinuation >> envelope: anObject [
	envelope := anObject
]
