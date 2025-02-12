Class {
	#name : 'PhxPjTestReadStream',
	#superclass : 'PhxPjAbstractTestCase',
	#category : 'Phx-Pj-Testing-Framework',
	#package : 'Phx-Pj-Testing-Framework'
}

{ #category : 'as yet unclassified' }
PhxPjTestReadStream >> testReadStream [

	| rs |
	rs := #() readStream.
	self assert: rs equals: rs readStream
]
