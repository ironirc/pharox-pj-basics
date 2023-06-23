Trait {
	#name : #PhxPjLoggingTrait,
	#category : #'Phx-Pj-Core-Traits'
}

{ #category : #logging }
PhxPjLoggingTrait >> log: anObject [

	self logAll: { anObject }.
	^anObject
]

{ #category : #logging }
PhxPjLoggingTrait >> logAll: args [

	PhxPjConsole logAll: args
]

{ #category : #logging }
PhxPjLoggingTrait >> logSelfAndAll: args [

	self logAll: { self } , args
]
