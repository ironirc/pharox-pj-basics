Class {
	#name : 'PhxEnvelopeWithContinuation',
	#superclass : 'Object',
	#instVars : [
		'envelope',
		'continuationBlock',
		'sentAtMsTimestamp'
	],
	#category : 'Phx-Pj-Client-Server-client-side',
	#package : 'Phx-Pj-Client-Server',
	#tag : 'client-side'
}

{ #category : 'instance creation' }
PhxEnvelopeWithContinuation class >> envelope: anEnvelope continuationBlock: aBlock [

	^ self new
		  envelope: anEnvelope;
		  continuationBlock: aBlock;
		  yourself
]

{ #category : 'accessing' }
PhxEnvelopeWithContinuation >> continuationBlock [
	^ continuationBlock
]

{ #category : 'accessing' }
PhxEnvelopeWithContinuation >> continuationBlock: anObject [
	continuationBlock := anObject
]

{ #category : 'accessing' }
PhxEnvelopeWithContinuation >> envelope [
	^ envelope
]

{ #category : 'accessing' }
PhxEnvelopeWithContinuation >> envelope: anObject [
	envelope := anObject
]

{ #category : 'as yet unclassified' }
PhxEnvelopeWithContinuation >> executeFor: aReqCtx [

	continuationBlock ifNotNil: [ :cb | cb value: aReqCtx ]
]

{ #category : 'accessing' }
PhxEnvelopeWithContinuation >> sentAtMsTimestamp [

	^ sentAtMsTimestamp
]

{ #category : 'accessing' }
PhxEnvelopeWithContinuation >> sentAtMsTimestamp: anObject [

	sentAtMsTimestamp := anObject
]
