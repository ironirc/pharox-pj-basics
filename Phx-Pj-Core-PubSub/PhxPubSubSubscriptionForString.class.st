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
PhxPubSubSubscriptionForString >> handleEvent: anEvent with: anArgument [

	(self canHandleEvent: anEvent) ifFalse: [ ^ self ].
	"PhxSpaConsole logAll: { 
			self class name.
			'handleEvent:'.
			anEvent.
			'handler:'.
			handler }."
	handler value: anArgument "apparently the handler block can have 0 arguments? side effect of PharoJs? (iow no need to use #cull:)"
]

{ #category : #accessing }
PhxPubSubSubscriptionForString >> string [

	^ string
]

{ #category : #accessing }
PhxPubSubSubscriptionForString >> string: anObject [
	string := anObject
]
