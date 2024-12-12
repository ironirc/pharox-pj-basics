Class {
	#name : 'PhxPjPubSubObjectForTesting',
	#superclass : 'Object',
	#traits : 'PhxPubSubTrait',
	#classTraits : 'PhxPubSubTrait classTrait',
	#category : 'Phx-Pj-Core-PubSub',
	#package : 'Phx-Pj-Core-PubSub'
}

{ #category : 'initialize' }
PhxPjPubSubObjectForTesting >> initialize [ 
	super initialize.
	self initializePubSubTrait
]
