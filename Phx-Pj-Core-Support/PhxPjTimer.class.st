Class {
	#name : 'PhxPjTimer',
	#superclass : 'PjDomController',
	#category : 'Phx-Pj-Core-Support',
	#package : 'Phx-Pj-Core-Support'
}

{ #category : 'api' }
PhxPjTimer class >> afterEveryMilliseconds: ms do: aBlock [
	<javascript:
		'return setInterval(aBlock,ms)'>
	
]

{ #category : 'api' }
PhxPjTimer class >> afterMilliseconds: ms do: aBlock [
	<javascript:
		'return setTimeout(aBlock,ms)'>
	
]

{ #category : 'api' }
PhxPjTimer class >> clearInterval: id [
	<javascript:
		'clearInterval(id)'>
	
]

{ #category : 'api' }
PhxPjTimer class >> clearTimeoutWithHandle: timeoutHandle [
	<javascript:
		'clearTimeout(timeoutHandle)'>
	
]

{ #category : 'api' }
PhxPjTimer class >> nextTickDo: aBlock [
	<javascript:
		'return setTimeout(aBlock,0)'>
	
]
