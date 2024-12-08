Class {
	#name : 'PhxPubSubSubscriptionForEventClass',
	#superclass : 'PhxPubSubSubscription',
	#instVars : [
		'eventClass'
	],
	#category : 'Phx-Pj-Core-PubSub',
	#package : 'Phx-Pj-Core-PubSub'
}

{ #category : 'accessing' }
PhxPubSubSubscriptionForEventClass >> canHandleEvent: anEventOrString [

	^ anEventOrString class = self eventClass
]

{ #category : 'accessing' }
PhxPubSubSubscriptionForEventClass >> eventClass [

	^ eventClass
]

{ #category : 'accessing' }
PhxPubSubSubscriptionForEventClass >> eventClass: anObject [

	eventClass := anObject
]

{ #category : 'accessing' }
PhxPubSubSubscriptionForEventClass >> handleEvent: anEvent with: nilArg [

	nilArg ifNotNil: [
		self error: 'no argument expected when the event is een object' ].
	(self canHandleEvent: anEvent) ifFalse: [ ^ self ].
	"PhxSpaConsole logAll: { 
			self class name.
			'handleEvent:'.
			anEvent.
			'handler:'.
			handler }."
	handler value: anEvent "apparently the handler block can have 0 arguments? side effect of PharoJs? (iow no need to use #cull:)"
]
