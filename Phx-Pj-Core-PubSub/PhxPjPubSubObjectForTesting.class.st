Class {
	#name : #PhxPjPubSubObjectForTesting,
	#superclass : #Object,
	#traits : 'PhxPubSubTrait',
	#classTraits : 'PhxPubSubTrait classTrait',
	#category : #'Phx-Pj-Core-PubSub-testing-client-side'
}

{ #category : #initialize }
PhxPjPubSubObjectForTesting >> initialize [ 
	super initialize.
	self initializePubSubTrait
]
