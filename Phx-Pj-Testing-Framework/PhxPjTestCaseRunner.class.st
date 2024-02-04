Class {
	#name : #PhxPjTestCaseRunner,
	#superclass : #PjDomController,
	#traits : 'PhxPjPromiseTrait + PhxPubSubTrait',
	#classTraits : 'PhxPjPromiseTrait classTrait + PhxPubSubTrait classTrait',
	#instVars : [
		'testCaseClass',
		'context'
	],
	#category : #'Phx-Pj-Testing-Framework'
}

{ #category : #'instance creation' }
PhxPjTestCaseRunner class >> newOnClass: aClass [

	^ self new
		  testCaseClass: aClass;
		  yourself
]

{ #category : #initialization }
PhxPjTestCaseRunner >> initialize [

	super initialize.
	self initializePubSubTrait.
	
]

{ #category : #'as yet unclassified' }
PhxPjTestCaseRunner >> promiseRun [

	^ (PhxPjAsyncIterator
		   on: self testCaseClass new methodNamesOfTests readStream
		   do: [ :methodName |
			   | runner |
			   runner := PhxPjTestMethodRunner
				             newForTestCaseRunner: self
				             methodName: methodName.
			   runner reEmitAllEventsOn: self.
			   runner promiseRun ]) then: [  ]
]

{ #category : #accessing }
PhxPjTestCaseRunner >> testCaseClass [

	^ testCaseClass
]

{ #category : #accessing }
PhxPjTestCaseRunner >> testCaseClass: anObject [

	testCaseClass := anObject
]
