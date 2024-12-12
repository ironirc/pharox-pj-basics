Class {
	#name : 'PhxPjPubSubObjectForTests',
	#superclass : 'Object',
	#traits : 'PhxPubSubTrait',
	#classTraits : 'PhxPubSubTrait classTrait',
	#category : 'Phx-Pj-Core-PubSub-Testing',
	#package : 'Phx-Pj-Core-PubSub-Testing'
}

{ #category : 'initialize' }
PhxPjPubSubObjectForTests >> initialize [ 
	super initialize.
	self initializePubSubTrait
]
