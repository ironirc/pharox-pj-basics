Class {
	#name : #PhxPseDeleted,
	#superclass : #PhxPubSubEvent,
	#instVars : [
		'subject'
	],
	#category : #'Phx-Pj-Core-PubSub'
}

{ #category : #accessing }
PhxPseDeleted >> subject [

	^ subject
]

{ #category : #accessing }
PhxPseDeleted >> subject: anObject [

	subject := anObject
]
