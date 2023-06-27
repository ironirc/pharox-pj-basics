Trait {
	#name : #PhxPubSubTrait,
	#instVars : [
		'psSubscriptions'
	],
	#category : #'Phx-Pj-Core-PubSub'
}

{ #category : #'pub-sub' }
PhxPubSubTrait >> emitEvent: anEventOrString [

	"self logAll: { 
			self class name.
			'emitEvent:'.
			anEventOrString.
			('to ' , psSubscriptions size , ' potential subscriptions') }.
"
	psSubscriptions do: [ :sub | sub handleEvent: anEventOrString ]
]

{ #category : #'pub-sub' }
PhxPubSubTrait >> initializePubSubTrait [
	psSubscriptions := OrderedCollection new.
]

{ #category : #'pub-sub' }
PhxPubSubTrait >> onEvent: anEventOrEventType do: aHandler [
	self onEvent: anEventOrEventType do: aHandler for: nil
]

{ #category : #'pub-sub' }
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
