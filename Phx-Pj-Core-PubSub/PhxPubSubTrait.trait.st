Trait {
	#name : #PhxPubSubTrait,
	#instVars : [
		'psSubscriptions'
	],
	#category : #'Phx-Pj-Core-PubSub'
}

{ #category : #'pub-sub traits' }
PhxPubSubTrait >> emitEvent: anEventOrString [

	self emitEvent: anEventOrString with: nil
]

{ #category : #'pub-sub traits' }
PhxPubSubTrait >> emitEvent: anEventOrString with: argument [

	"self logAll: { 
			self class name.
			'emitEvent:'.
			anEventOrString.
			('to ' , psSubscriptions size , ' potential subscriptions') }."

	psSubscriptions do: [ :sub | sub handleEvent: anEventOrString with: argument ]
]

{ #category : #'pub-sub traits' }
PhxPubSubTrait >> initializePubSubTrait [
	psSubscriptions := OrderedCollection new.
]

{ #category : #'pub-sub traits' }
PhxPubSubTrait >> onEvent: anEventOrEventType do: aHandler [
	self onEvent: anEventOrEventType do: aHandler for: nil
]

{ #category : #'pub-sub traits' }
PhxPubSubTrait >> onEvent: anEventTypeOrString do: aHandler for: aSubscriber [

	| newSub |
	[ 
	psSubscriptions anySatisfy: [ :sub | 
		sub handler == aHandler and: [ 
			aSubscriber isNil or: [ aSubscriber = sub subscriber ] ] ] ] 
		ifTrue: [ ^ self "avoid duplicate event handlers" ].
	newSub := anEventTypeOrString asPhxPubSubSubscription.
	newSub
		handler: aHandler;
		subscriber: aSubscriber.
	psSubscriptions add: newSub.
	"self logAll: { 
			self class name.
			'onEvent:'.
			anEventTypeOrString.
			'subcription:'.
			newSub }"
]

{ #category : #'pub-sub traits' }
PhxPubSubTrait >> reEmitAllEventsOn: anObject [

	psSubscriptions add: (PhxPubSubSubscriptionPassAll new
			 object: anObject;
			 yourself)
]
