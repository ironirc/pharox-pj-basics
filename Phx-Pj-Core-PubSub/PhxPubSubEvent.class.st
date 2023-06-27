Class {
	#name : #PhxPubSubEvent,
	#superclass : #Object,
	#category : #'Phx-Pj-Core-PubSub'
}

{ #category : #converting }
PhxPubSubEvent class >> asPhxPubSubSubscription [

	^ PhxPubSubSubscriptionForEventClass new
		  eventClass: self;
		  yourself
]
