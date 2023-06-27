Class {
	#name : #PhxPubSubSubscriptionForString,
	#superclass : #PhxPubSubSubscription,
	#instVars : [
		'string'
	],
	#category : #'Phx-Pj-Core-PubSub'
}

{ #category : #accessing }
PhxPubSubSubscriptionForString >> canHandleEvent: anEventOrString [

	"PhxSpaConsole logAll: { 
			'canHandleEvent:'.
			anEventOrString.
			'self string:'.
			self string.
			'result:'.
			(anEventOrString = self string) }."
	^ anEventOrString asJsObject = self string asJsObject
]

{ #category : #accessing }
PhxPubSubSubscriptionForString >> string [

	^ string
]

{ #category : #accessing }
PhxPubSubSubscriptionForString >> string: anObject [
	string := anObject
]
