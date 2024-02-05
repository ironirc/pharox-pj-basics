Trait {
	#name : #PhxPjLoggingTrait,
	#category : #'Phx-Pj-Core-Traits'
}

{ #category : #'logging traits' }
PhxPjLoggingTrait >> console [

	<javascript: 'return console'>
	
]

{ #category : #'logging traits' }
PhxPjLoggingTrait >> log: anObject [

	self logAll: { anObject }.
	^anObject
]

{ #category : #'logging traits' }
PhxPjLoggingTrait >> log: label timeToRun: aBlock [

	| start |
	start := self now.
	aBlock value.
	self logAll: {
			label.
			(self now - start) }
]

{ #category : #'logging traits' }
PhxPjLoggingTrait >> logAll: args [

	<javascript: 'console.log(...args)'>
]

{ #category : #'logging traits' }
PhxPjLoggingTrait >> logSelfAndAll: args [

	self logAll: { self } , args
]

{ #category : #'logging traits' }
PhxPjLoggingTrait >> now [

	<javascript: 'return window.performance.now()'>
	
]

{ #category : #'logging traits' }
PhxPjLoggingTrait >> profile: aBlock labeled: aLabel [

	self console profile: aLabel.
	aBlock value.
	self console profileEnd: aLabel
]
