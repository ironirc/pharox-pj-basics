Class {
	#name : 'PhxPjTestResultFail',
	#superclass : 'PhxPjAbstractTestResult',
	#instVars : [
		'description'
	],
	#category : 'Phx-Pj-Testing-Framework',
	#package : 'Phx-Pj-Testing-Framework'
}

{ #category : 'accessing' }
PhxPjTestResultFail >> cssOn: eb [  

	eb _class: 'test-case-fail'
]

{ #category : 'accessing' }
PhxPjTestResultFail >> description [

	^ description
]

{ #category : 'accessing' }
PhxPjTestResultFail >> description: anObject [

	description := anObject
]

{ #category : 'accessing' }
PhxPjTestResultFail >> renderDetailsOn: eb [

	eb << self description
]
