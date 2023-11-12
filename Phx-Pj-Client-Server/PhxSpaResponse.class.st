Class {
	#name : #PhxSpaResponse,
	#superclass : #PhxSpaAbstractMessage,
	#instVars : [
		'isSuccess',
		'type',
		'message'
	],
	#category : #'Phx-Pj-Client-Server-shared'
}

{ #category : #testing }
PhxSpaResponse >> expectsResponseFromClient [ 
	^false
]

{ #category : #'initialize-release' }
PhxSpaResponse >> initialize [
	isSuccess := false
]

{ #category : #accessing }
PhxSpaResponse >> isError [
	^ self type == #error
]

{ #category : #accessing }
PhxSpaResponse >> isSuccess [
	^ self type == #success
]

{ #category : #accessing }
PhxSpaResponse >> isSuccess: aBoolean [
	self flag: 'should be removed'.
	aBoolean ifTrue: [ self type: #success ]
]

{ #category : #accessing }
PhxSpaResponse >> isWarning [
	^ self type == #warning
]

{ #category : #accessing }
PhxSpaResponse >> message [
	^ message
]

{ #category : #accessing }
PhxSpaResponse >> message: anObject [
	message := anObject
]

{ #category : #accessing }
PhxSpaResponse >> type [

	^ type
]

{ #category : #accessing }
PhxSpaResponse >> type: anObject [

	type := anObject
]
