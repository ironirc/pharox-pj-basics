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

	^ self promiseRace: {
			  (self promise: aBlock).
			  (self promiseTimeoutAfterMs: ms) }
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

{ #category : #promises }
PhxPjPromiseTrait >> promiseTimeoutAfterMs: ms [
	<javascript: 'return new Promise((resolve, reject) => setTimeout(() => reject(new Error("Timeout")), ms))'>
]
