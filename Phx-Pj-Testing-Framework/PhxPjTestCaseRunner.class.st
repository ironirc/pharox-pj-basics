Class {
	#name : 'PhxPjTestCaseRunner',
	#superclass : 'PjDomController',
	#traits : 'PhxPjPromiseTrait + PhxPubSubTrait',
	#classTraits : 'PhxPjPromiseTrait classTrait + PhxPubSubTrait classTrait',
	#instVars : [
		'testCaseClass'
	],
	#category : 'Phx-Pj-Testing-Framework',
	#package : 'Phx-Pj-Testing-Framework'
}

{ #category : 'instance creation' }
PhxPjTestCaseRunner class >> newOnClass: aClass [

	^ self new
		  testCaseClass: aClass;
		  yourself
]

{ #category : 'initialization' }
PhxPjTestCaseRunner >> initialize [

	super initialize.
	self initializePubSubTrait.
	
]

{ #category : 'as yet unclassified' }
PhxPjTestCaseRunner >> methodNamesOfTestsToBeRun [

	| results |
	"self testCaseClass == PhxPjTestTestingFrameworkBasics ifFalse: [
		^ #() ]."

	results := self testCaseClass new methodNamesOfTests.
	"results := results select: [ :e | e = 'testAsyncError' ]."
	^ results
]

{ #category : 'as yet unclassified' }
PhxPjTestCaseRunner >> promiseRun [

	^ (PhxPjAsyncIterator
		   on: self methodNamesOfTestsToBeRun readStream
		   do: [ :methodName |
			   | runner |
			   runner := PhxPjTestMethodRunner
				             newForTestCaseRunner: self
				             methodName: methodName.
			   runner reEmitAllEventsOn: self.
			   runner promiseRun ]) then: [  ]
]

{ #category : 'accessing' }
PhxPjTestCaseRunner >> testCaseClass [

	^ testCaseClass
]

{ #category : 'accessing' }
PhxPjTestCaseRunner >> testCaseClass: anObject [

	testCaseClass := anObject
]
