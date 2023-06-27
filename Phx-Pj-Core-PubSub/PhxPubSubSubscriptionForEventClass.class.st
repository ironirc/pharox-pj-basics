Class {
	#name : #PhxPubSubSubscriptionForEventClass,
	#superclass : #PhxPubSubSubscription,
	#instVars : [
		'eventClass'
	],
	#category : #'Phx-Pj-Core-PubSub'
}

{ #category : #accessing }
PhxPubSubSubscriptionForEventClass >> canHandleEvent: anEventOrString [

	^ anEventOrString class = self eventClass
]

{ #category : #accessing }
PhxPubSubSubscriptionForEventClass >> eventClass [

	^ eventClass
]

{ #category : #accessing }
PhxPubSubSubscriptionForEventClass >> eventClass: anObject [

	eventClass := anObject
]
