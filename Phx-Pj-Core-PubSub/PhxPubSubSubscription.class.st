Class {
	#name : #PhxPubSubSubscription,
	#superclass : #PjDomController,
	#instVars : [
		'handler',
		'subscriber'
	],
	#category : #'Phx-Pj-Core-PubSub'
}

{ #category : #events }
PhxPubSubSubscription >> canHandleEvent: anEventOrString [

	self subclassResponsibility
]

{ #category : #events }
PhxPubSubSubscription >> handleEvent: anEventOrString [

	(self canHandleEvent: anEventOrString) ifFalse: [ ^ self ].
	"PhxSpaConsole logAll: { 
			self class name.
			'handleEvent:'.
			anEventOrString.
			'handler:'.
			handler }."
	handler value: anEventOrString "apparently the handler block can have 0 arguments? side effect of PharoJs?"
]

{ #category : #accessing }
PhxPubSubSubscription >> handler [
	^ handler
]

{ #category : #accessing }
PhxPubSubSubscription >> handler: anObject [
	handler := anObject
]

{ #category : #accessing }
PhxPubSubSubscription >> subscriber [

	^ subscriber
]

{ #category : #accessing }
PhxPubSubSubscription >> subscriber: anObject [

	subscriber := anObject
]
