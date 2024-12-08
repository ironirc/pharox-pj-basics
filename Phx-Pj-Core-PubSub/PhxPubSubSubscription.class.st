Class {
	#name : 'PhxPubSubSubscription',
	#superclass : 'PjDomController',
	#instVars : [
		'handler',
		'subscriber'
	],
	#category : 'Phx-Pj-Core-PubSub',
	#package : 'Phx-Pj-Core-PubSub'
}

{ #category : 'events' }
PhxPubSubSubscription >> canHandleEvent: anEventOrString [

	self subclassResponsibility
]

{ #category : 'accessing' }
PhxPubSubSubscription >> handler [
	^ handler
]

{ #category : 'accessing' }
PhxPubSubSubscription >> handler: anObject [
	handler := anObject
]

{ #category : 'accessing' }
PhxPubSubSubscription >> subscriber [

	^ subscriber
]

{ #category : 'accessing' }
PhxPubSubSubscription >> subscriber: anObject [

	subscriber := anObject
]
