Trait {
	#name : 'PhxPjPromiseTrait',
	#category : 'Phx-Pj-Core-Traits',
	#package : 'Phx-Pj-Core-Traits'
}

{ #category : 'services' }
PhxPjPromiseTrait classSide >> promise: aBlock [
	<javascript: 'return new Promise(aBlock)'>
]

{ #category : 'services' }
PhxPjPromiseTrait classSide >> promiseAll: anArray [
	<javascript: 'return Promise.all(anArray)'>

]

{ #category : 'services' }
PhxPjPromiseTrait classSide >> promiseResolve: aValue [
	<javascript: 'return Promise.resolve(aValue)'>
]

{ #category : 'promise traits' }
PhxPjPromiseTrait >> promise: aBlock [
	<javascript: 'return new Promise(aBlock)'>
]

{ #category : 'promise traits' }
PhxPjPromiseTrait >> promise: aBlock withinMs: ms [

	^ self promise: aBlock withinMs: ms onTimeout: [ :resolve :reject |
		  reject value:
			  (Error new messageText: 'Timeout after ' + ms printString + ' ms') ]
]

{ #category : 'promise traits' }
PhxPjPromiseTrait >> promise: aBlock withinMs: ms onTimeout: timeoutBlock [

	^ self promise: [ :resolve :reject |
		  | timeoutId |
		  timeoutId := PhxPjTimer
			               afterMilliseconds: ms
			               do: [ timeoutBlock value: resolve value: reject ].
		  (((self promise: aBlock) then: [ :result | resolve value: result ])
			   catch: [ :ex | reject value: ex ]) finally: [
			  PhxPjTimer clearTimeoutWithHandle: timeoutId ] ]
]

{ #category : 'promise traits' }
PhxPjPromiseTrait >> promiseAll: anArray [
	<javascript: 'return Promise.all(anArray)'>

]

{ #category : 'promise traits' }
PhxPjPromiseTrait >> promiseRace: blocks [
	<javascript: 'return Promise.race(blocks)'>
]

{ #category : 'promise traits' }
PhxPjPromiseTrait >> promiseReject: aValue [
	<javascript: 'return Promise.reject(aValue)'>
]

{ #category : 'promise traits' }
PhxPjPromiseTrait >> promiseResolve: aValue [
	<javascript: 'return Promise.resolve(aValue)'>
]
