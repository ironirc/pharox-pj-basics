Class {
	#name : #PhxPjTimer,
	#superclass : #PjDomController,
	#category : #'Phx-Pj-Core-Support'
}

{ #category : #'as yet unclassified' }
PhxPjTimer class >> afterEveryMilliseconds: ms do: aBlock [
	<javascript:
		'return setInterval(aBlock,ms)'>
	
]

{ #category : #'as yet unclassified' }
PhxPjTimer class >> afterMilliseconds: ms do: aBlock [
	<javascript:
		'return setTimeout(aBlock,ms)'>
	
]

{ #category : #'as yet unclassified' }
PhxPjTimer class >> clearInterval: id [
	<javascript:
		'clearInterval(id)'>
	
]

{ #category : #'as yet unclassified' }
PhxPjTimer class >> clearTimeoutWithHandle: timeoutHandle [
	<javascript:
		'clearTimeout(timeoutHandle)'>
	
]
