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

{ #category : #promises }
PhxPjPromiseTrait >> promise: aBlock [
	<javascript: 'return new Promise(aBlock)'>
]

{ #category : #promises }
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

{ #category : #promises }
PhxPjPromiseTrait >> promiseAll: anArray [
	<javascript: 'return Promise.all(anArray)'>

]

{ #category : #promises }
PhxPjPromiseTrait >> promiseRace: blocks [
	<javascript: 'return Promise.race(blocks)'>
]

{ #category : #promises }
PhxPjPromiseTrait >> promiseReject: aValue [
	<javascript: 'return Promise.reject(aValue)'>
]

{ #category : #promises }
PhxPjPromiseTrait >> promiseResolve: aValue [
	<javascript: 'return Promise.resolve(aValue)'>
]
