Class {
	#name : 'PhxPjAbstractTestCase',
	#superclass : 'PjDomController',
	#traits : 'PhxPjPromiseTrait + PhxPubSubTrait + PhxPjLoggingTrait',
	#classTraits : 'PhxPjPromiseTrait classTrait + PhxPubSubTrait classTrait + PhxPjLoggingTrait classTrait',
	#category : 'Phx-Pj-Testing-Framework',
	#package : 'Phx-Pj-Testing-Framework'
}

{ #category : 'constants' }
PhxPjAbstractTestCase class >> timeoutMs [

	^ 3000
]

{ #category : 'asserting' }
PhxPjAbstractTestCase >> assert: aBooleanOrBlock description: aDescription [

	aBooleanOrBlock value ifFalse: [
		self emitEvent: (PhxPjTestResultFail new
				 description: aDescription value;
				 yourself) ]
]

{ #category : 'asserting' }
PhxPjAbstractTestCase >> assert: actual equals: expected [

	actual = expected ifFalse: [
		self fail: (String streamContents: [ :ws |
				 ws << 'expected: ' << expected printString << ' instead got: '
				 << actual printString ]) ]
]

{ #category : 'asserting' }
PhxPjAbstractTestCase >> fail: aDescription [
	self assert: false description: aDescription
]

{ #category : 'initialize' }
PhxPjAbstractTestCase >> initialize [

	super initialize.
	self initializePubSubTrait.
	
]

{ #category : 'accessing method names' }
PhxPjAbstractTestCase >> methodNames [

	^ Array streamContents: [ :ws |
		  self methodNamesRaw do: [ :e |
			  e = 'constructor' ifFalse: [
				  ws nextPut: (e copyFrom: 4 to: e size) ] ] ]
]

{ #category : 'accessing method names' }
PhxPjAbstractTestCase >> methodNamesOfTests [

	^ self methodNames select: [ :name | name beginsWith: 'test' ]
]

{ #category : 'accessing method names' }
PhxPjAbstractTestCase >> methodNamesRaw [

	^ (Object js_getOwnPropertyNames: (Object js_getPrototypeOf: self))
	
	
]

{ #category : 'initialize' }
PhxPjAbstractTestCase >> setup [

	
]

{ #category : 'asserting' }
PhxPjAbstractTestCase >> should: aBlock raise: anExceptionalEvent [

	aBlock
		on: anExceptionalEvent
		do: [ :ex | ^ self ].
	self fail: 'expected exception: ' , anExceptionalEvent name
]

{ #category : 'asserting' }
PhxPjAbstractTestCase >> shouldRaiseError: aBlock [

	self should: aBlock raise: Error
]

{ #category : 'initialize' }
PhxPjAbstractTestCase >> tearDown [

	
]

{ #category : 'accessing derived' }
PhxPjAbstractTestCase >> timeoutMsForMethod: aMethodName [
	^self class timeoutMs


]
