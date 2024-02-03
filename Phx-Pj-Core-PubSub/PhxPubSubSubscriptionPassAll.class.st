Class {
	#name : #PhxPubSubSubscriptionPassAll,
	#superclass : #PhxPubSubSubscription,
	#instVars : [
		'object'
	],
	#category : #'Phx-Pj-Core-PubSub'
}

{ #category : #events }
PhxPubSubSubscriptionPassAll >> canHandleEvent: anEventOrString [
	^true
]

{ #category : #events }
PhxPubSubSubscriptionPassAll >> handleEvent: anEventOrString [

	self object emitEvent: anEventOrString
]

{ #category : #accessing }
PhxPubSubSubscriptionPassAll >> object [

	^ object
]

{ #category : #accessing }
PhxPubSubSubscriptionPassAll >> object: anObject [

	object := anObject
]
