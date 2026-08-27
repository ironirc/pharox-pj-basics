Class {
	#name : 'PhxPjAsyncIterator',
	#superclass : 'PjDomController',
	#traits : 'PhxPjPromiseTrait',
	#classTraits : 'PhxPjPromiseTrait classTrait',
	#instVars : [
		'readStream',
		'block'
	],
	#category : 'Phx-Pj-Core-Support',
	#package : 'Phx-Pj-Core-Support'
}

{ #category : 'convenience' }
PhxPjAsyncIterator class >> on: collectionOrStream do: aBlock [
	
	^self new
		readStream: collectionOrStream readStream;
		block: aBlock;
		promiseDoAll
]

{ #category : 'convenience' }
PhxPjAsyncIterator class >> reduce: collectionOrStream [

	^ self reduce: collectionOrStream with: nil
]

{ #category : 'convenience' }
PhxPjAsyncIterator class >> reduce: collectionOrStream with: arg [

	^ self new
		  readStream: collectionOrStream readStream;
		  reduceWith: arg
]

{ #category : 'accessing' }
PhxPjAsyncIterator >> block [

	^ block
]

{ #category : 'accessing' }
PhxPjAsyncIterator >> block: anObject [

	block := anObject
]

{ #category : 'private' }
PhxPjAsyncIterator >> promiseDoAll [

	^ readStream atEnd
		  ifTrue: [ self promiseResolve: nil ]
		  ifFalse: [
			  (self promiseResolve: (block value: readStream next)) then: [
				  self promiseDoAll ] ]
]

{ #category : 'accessing' }
PhxPjAsyncIterator >> readStream [

	^ readStream
]

{ #category : 'accessing' }
PhxPjAsyncIterator >> readStream: anObject [

	readStream := anObject
]

{ #category : 'private' }
PhxPjAsyncIterator >> reduceWith: accum [

	^ readStream atEnd
		  ifTrue: [ self promiseResolve: accum ]
		  ifFalse: [
			  (self promiseResolve: (readStream next cull: accum)) then: [
				  :result | self reduceWith: result ] ]
]
