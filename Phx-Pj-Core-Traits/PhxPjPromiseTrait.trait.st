Trait {
	#name : #PhxPjPromiseTrait,
	#category : #'Phx-Pj-Core-Traits'
}

{ #category : #services }
PhxPjPromiseTrait classSide >> promise: aBlock [
	<javascript: 'return new Promise(aBlock)'>
]

{ #category : #services }
PhxPjPromiseTrait classSide >> promiseAll: anArray [
	<javascript: 'return Promise.all(anArray)'>

]

{ #category : #services }
PhxPjPromiseTrait classSide >> promiseResolve: aValue [
	<javascript: 'return Promise.resolve(aValue)'>
]

{ #category : #'promise traits' }
PhxPjPromiseTrait >> isPromise: anObject [

	<javascript: 'return obj === Promise.resolve(anObject);'>
	
]

{ #category : #'promise traits' }
PhxPjPromiseTrait >> promise: aBlock [
	<javascript: 'return new Promise(aBlock)'>
]

{ #category : #'promise traits' }
PhxPjPromiseTrait >> promise: aBlock withinMs: ms [

	^ self promise: [ :res :rej |
		  | timeoutId |
		  timeoutId := PhxPjTimer  afterMilliseconds: ms do: [
			               rej value:
				               (Error new messageText:
					                'Timeout after ' + ms printString + ' ms') ].
		  (self promise: aBlock) then: [ :result |
			  PhxPjTimer clearTimeoutWithHandle: timeoutId.
			  res value: result ] ]
]

{ #category : #'promise traits' }
PhxPjPromiseTrait >> promiseAll: anArray [
	<javascript: 'return Promise.all(anArray)'>

]

{ #category : #'promise traits' }
PhxPjPromiseTrait >> promiseRace: blocks [
	<javascript: 'return Promise.race(blocks)'>
]

{ #category : #'promise traits' }
PhxPjPromiseTrait >> promiseReject: aValue [
	<javascript: 'return Promise.reject(aValue)'>
]

{ #category : #'promise traits' }
PhxPjPromiseTrait >> promiseResolve: aValue [
	<javascript: 'return Promise.resolve(aValue)'>
]
