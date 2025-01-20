Class {
	#name : 'PhxPjTestTestingFrameworkBasics',
	#superclass : 'PhxPjAbstractTestCase',
	#category : 'Phx-Pj-Testing-Framework',
	#package : 'Phx-Pj-Testing-Framework'
}

{ #category : 'tests' }
PhxPjTestTestingFrameworkBasics >> testAsyncError [

	^ self promise: [ :resolve :reject |
		  PhxPjTimer
			  afterMilliseconds: 10
			  do: [ reject value: 'deliberatly rejected the promise' ] ]
]

{ #category : 'tests' }
PhxPjTestTestingFrameworkBasics >> testAsyncTest [

	^ self promise: [ :resolve :reject |
		  PhxPjTimer afterMilliseconds: 3 do: [
			  self assert: 1 equals: 1.
			  resolve value ] ]
]

{ #category : 'tests' }
PhxPjTestTestingFrameworkBasics >> testAsyncTestTimeout [
	"timeout for this specific method is set to 10ms (see timeoutMsForMethod:)"

	^ self promise: [ :resolve :reject |
		  PhxPjTimer afterMilliseconds: 100 do: [
			  self assert: 1 equals: 1.
			  resolve value ] ]
]

{ #category : 'tests' }
PhxPjTestTestingFrameworkBasics >> testDeliberateFail [

	self assert: 1 equals: 0
]

{ #category : 'tests' }
PhxPjTestTestingFrameworkBasics >> testExpectedErrorZeroDivide [

	self should: [ 1 / 0 ] raise: Error
]

{ #category : 'tests' }
PhxPjTestTestingFrameworkBasics >> testSimpleAssertion [

	self assert: 'ivo' equals: 'ivo'
]

{ #category : 'accessing derived' }
PhxPjTestTestingFrameworkBasics >> timeoutMsForMethod: aMethodName [

	aMethodName = #testAsyncTestTimeout ifTrue: [ ^ 10 ].
	^ super timeoutMsForMethod: aMethodName
]
