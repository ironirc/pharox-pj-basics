Class {
	#name : #PhxPseChanged,
	#superclass : #PhxPubSubEvent,
	#instVars : [
		'newValue',
		'oldValue'
	],
	#category : #'Phx-Pj-Core-PubSub'
}

{ #category : #accessing }
PhxPseChanged >> newValue [
	^ newValue
]

{ #category : #accessing }
PhxPseChanged >> newValue: anObject [
	newValue := anObject
]

{ #category : #accessing }
PhxPseChanged >> oldValue [
	^ oldValue
]

{ #category : #accessing }
PhxPseChanged >> oldValue: anObject [
	oldValue := anObject
]
