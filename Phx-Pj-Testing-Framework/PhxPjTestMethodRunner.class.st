Class {
	#name : 'PhxPjTestMethodRunner',
	#superclass : 'PjDomController',
	#traits : 'PhxPjPromiseTrait + PhxPubSubTrait + PhxPjLoggingTrait',
	#classTraits : 'PhxPjPromiseTrait classTrait + PhxPubSubTrait classTrait + PhxPjLoggingTrait classTrait',
	#instVars : [
		'methodName',
		'testCaseRunner',
		'startTime',
		'isFailure',
		'isError',
		'testCase'
	],
	#category : 'Phx-Pj-Testing-Framework',
	#package : 'Phx-Pj-Testing-Framework'
}

{ #category : 'instance-creation' }
PhxPjTestMethodRunner class >> newForTestCaseRunner: aTestCaseRunner methodName: aMethodName [

	^ self new
		  testCaseRunner: aTestCaseRunner;
		  methodName: aMethodName;
		  yourself
]

{ #category : 'initialization' }
PhxPjTestMethodRunner >> initialize [

	super initialize.
	self initializePubSubTrait.
	isFailure := false.
	isError := false
]

{ #category : 'accessing' }
PhxPjTestMethodRunner >> methodName [

	^ methodName
]

{ #category : 'accessing' }
PhxPjTestMethodRunner >> methodName: anObject [

	methodName := anObject
]

{ #category : 'private' }
PhxPjTestMethodRunner >> methodNameSuffix: mn [

	^ mn copyFrom: 5 to: mn size
]

{ #category : 'private' }
PhxPjTestMethodRunner >> now [

	^ globalThis performance now
]

{ #category : 'public' }
PhxPjTestMethodRunner >> promiseRun [

	^ self runSafely finally: [
		  isFailure | isError ifFalse: [
			  self emitEvent: (PhxPjTestResultSuccess new
					   testCaseClass: self testCaseRunner testCaseClass;
					   methodName: self methodName;
					   timeToRun: self timeSinceStart;
					   yourself) ] ]
]

{ #category : 'private' }
PhxPjTestMethodRunner >> promiseSetup [

	^ self promiseResolve: testCase setup
]

{ #category : 'private' }
PhxPjTestMethodRunner >> promiseTearDown [
	^self promiseResolve: testCase tearDown

	
]

{ #category : 'private' }
PhxPjTestMethodRunner >> runSafely [

	self setStartTime.
	^ self setup_run_tearDown catch: [ :ex |
		console trace. 
		  self emitEvent: (PhxPjTestResultError new
				   testCaseClass: self testCaseClass;
				   methodName: self methodName;
				   timeToRun: self timeSinceStart;
				   originalError: ex;
				   yourself).
		  isError := true ]
]

{ #category : 'private' }
PhxPjTestMethodRunner >> runUnprotected [

	^ self promiseResolve: (testCase perform: self methodName)
]

{ #category : 'private' }
PhxPjTestMethodRunner >> setStartTime [

	startTime := self now
]

{ #category : 'private' }
PhxPjTestMethodRunner >> setup_run_tearDown [

	testCase := self testCaseClass new.
	testCase onEvent: PhxPjTestResultFail do: [ :ev |
		isFailure := true.
		ev
			testCaseClass: self testCaseRunner testCaseClass;
			methodName: self methodName;
			timeToRun: self timeSinceStart.
		self emitEvent: ev ].
	^ self
		  promise: [ :resolve :reject |
			  ((self promiseSetup then: [
				    self runUnprotected then: [ resolve value ] ]) catch: [ :ex |
				   reject value: ex ]) finally: [ self promiseTearDown ] ]
		  withinMs: self timeoutMs
]

{ #category : 'accessing derived' }
PhxPjTestMethodRunner >> testCaseClass [

	^ self testCaseRunner testCaseClass
]

{ #category : 'accessing' }
PhxPjTestMethodRunner >> testCaseRunner [

	^ testCaseRunner
]

{ #category : 'accessing' }
PhxPjTestMethodRunner >> testCaseRunner: anObject [

	testCaseRunner := anObject
]

{ #category : 'private' }
PhxPjTestMethodRunner >> timeSinceStart [

	^ self now - startTime
]

{ #category : 'private' }
PhxPjTestMethodRunner >> timeoutMs [

	^ testCase timeoutMsForMethod: self methodName
]
