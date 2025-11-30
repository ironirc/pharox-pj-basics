Class {
	#name : 'PhxPjTestStartedOnMethod',
	#superclass : 'PhxPjAbstractTestEvent',
	#instVars : [
		'testCaseClass',
		'methodName'
	],
	#category : 'Phx-Pj-Testing-Framework',
	#package : 'Phx-Pj-Testing-Framework'
}

{ #category : 'printing' }
PhxPjTestStartedOnMethod >> asText [

	^ String streamContents: [ :ws |
		  ws << self className << ' - ' << self methodName << ' ('
		  << (self timeToRun js_toFixed: 1) << 'ms) '.
		  ws cr.
		  ws << 's' ]
]

{ #category : 'rendering' }
PhxPjTestStartedOnMethod >> cssOn: eb [

	
]

{ #category : 'accessing' }
PhxPjTestStartedOnMethod >> methodName [

	^ methodName
]

{ #category : 'accessing' }
PhxPjTestStartedOnMethod >> methodName: anObject [

	methodName := anObject
]

{ #category : 'rendering' }
PhxPjTestStartedOnMethod >> renderClassAndMethodNameOn: x [
	"<< self testCaseClass name << '>>' "

	^ x << self methodName
]

{ #category : 'rendering' }
PhxPjTestStartedOnMethod >> renderDetailsOn: eb [

	
]

{ #category : 'rendering' }
PhxPjTestStartedOnMethod >> renderOn: eb [

	eb div: [
		self cssOn: eb.
		self renderClassAndMethodNameOn: eb.
		eb << ' (' << (self timeToRun js_toFixed: 1) << 'ms) '.
		self renderDetailsOn: eb.
		"eb << ' '	. 
		eb button: [
			eb onClick: [ self testCaseClass new perform: self methodName ].
			eb << 'run' ]" ]
]

{ #category : 'accessing' }
PhxPjTestStartedOnMethod >> testCaseClass [

	^ testCaseClass
]

{ #category : 'accessing' }
PhxPjTestStartedOnMethod >> testCaseClass: anObject [

	testCaseClass := anObject
]
