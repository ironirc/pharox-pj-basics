Class {
	#name : #PhxPjTestResultError,
	#superclass : #PhxPjAbstractTestResult,
	#instVars : [
		'originalError'
	],
	#category : #'Phx-Pj-Testing-Framework'
}

{ #category : #accessing }
PhxPjTestResultError >> cssOn: eb [  

	eb _class: 'test-case-error'
]

{ #category : #accessing }
PhxPjTestResultError >> originalError [

	^ originalError
]

{ #category : #accessing }
PhxPjTestResultError >> originalError: anObject [

	originalError := anObject
]

{ #category : #accessing }
PhxPjTestResultError >> renderDetailsOn: eb [

	eb << self originalError description
]
