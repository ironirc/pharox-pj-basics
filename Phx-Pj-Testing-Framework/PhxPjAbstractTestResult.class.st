Class {
	#name : 'PhxPjAbstractTestResult',
	#superclass : 'PhxPubSubEvent',
	#traits : 'PhxPjPromiseTrait',
	#classTraits : 'PhxPjPromiseTrait classTrait',
	#instVars : [
		'testCaseClass',
		'methodName',
		'timeToRun'
	],
	#category : 'Phx-Pj-Testing-Framework',
	#package : 'Phx-Pj-Testing-Framework'
}

{ #category : 'printing' }
PhxPjAbstractTestResult >> asText [

	^ String streamContents: [ :ws |
		  ws << self className << ' - ' << self methodName << ' ('
		  << (self timeToRun js_toFixed: 1) << 'ms) '.
		  ws cr.
		  ws << 's' ]
]

{ #category : 'rendering' }
PhxPjAbstractTestResult >> cssOn: eb [

	
]

{ #category : 'accessing' }
PhxPjAbstractTestResult >> methodName [

	^ methodName
]

{ #category : 'accessing' }
PhxPjAbstractTestResult >> methodName: anObject [

	methodName := anObject
]

{ #category : 'rendering' }
PhxPjAbstractTestResult >> renderClassAndMethodNameOn: x [
	"<< self testCaseClass name << '>>' "

	^ x << self methodName
]

{ #category : 'rendering' }
PhxPjAbstractTestResult >> renderDetailsOn: eb [

	
]

{ #category : 'rendering' }
PhxPjAbstractTestResult >> renderOn: eb [

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
PhxPjAbstractTestResult >> testCaseClass [

	^ testCaseClass
]

{ #category : 'accessing' }
PhxPjAbstractTestResult >> testCaseClass: anObject [

	testCaseClass := anObject
]

{ #category : 'accessing' }
PhxPjAbstractTestResult >> timeToRun [

	^ timeToRun
]

{ #category : 'accessing' }
PhxPjAbstractTestResult >> timeToRun: anObject [

	timeToRun := anObject
]
