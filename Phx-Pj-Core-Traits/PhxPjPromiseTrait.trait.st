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
PhxPjPromiseTrait >> promiseAll: anArray [
	<javascript: 'return Promise.all(anArray)'>

]

{ #category : #promises }
PhxPjPromiseTrait >> promiseResolve: aValue [
	<javascript: 'return Promise.resolve(aValue)'>
]
