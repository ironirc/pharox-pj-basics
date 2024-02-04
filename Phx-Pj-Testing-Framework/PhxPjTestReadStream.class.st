Class {
	#name : #PhxPjTestReadStream,
	#superclass : #PhxPjAbstractTestCase,
	#category : #'Phx-Pj-Testing-Framework'
}

{ #category : #tests }
PhxPjTestReadStream >> testReadStream [

	| rs |
	rs := #() readStream.
	self assert: rs equals: rs readStream
]
