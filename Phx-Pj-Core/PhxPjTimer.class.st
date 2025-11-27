Class {
	#name : 'PhxPjTimer',
	#superclass : 'PjDomController',
	#category : 'Phx-Pj-Core',
	#package : 'Phx-Pj-Core'
}

{ #category : 'as yet unclassified' }
PhxPjTimer class >> afterEveryMilliseconds: ms do: aBlock [
	<javascript:
		'return setInterval(aBlock,ms)'>
	
]

{ #category : 'as yet unclassified' }
PhxPjTimer class >> afterMilliseconds: ms do: aBlock [
	<javascript:
		'return setTimeout(aBlock,ms)'>
	
]

{ #category : 'as yet unclassified' }
PhxPjTimer class >> clearInterval: id [
	<javascript:
		'clearInterval(id)'>
	
]

{ #category : 'as yet unclassified' }
PhxPjTimer class >> clearTimeoutWithHandle: timeoutHandle [
	<javascript:
		'clearTimeout(timeoutHandle)'>
	
]

{ #category : 'as yet unclassified' }
PhxPjTimer class >> nextTickDo: aBlock [
	<javascript:
		'return setTimeout(aBlock,0)'>
	
]
