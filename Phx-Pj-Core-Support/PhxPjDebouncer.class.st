Class {
	#name : 'PhxPjDebouncer',
	#superclass : 'PjDomController',
	#instVars : [
		'ms',
		'handle'
	],
	#category : 'Phx-Pj-Core-Support',
	#package : 'Phx-Pj-Core-Support'
}

{ #category : 'accessing' }
PhxPjDebouncer class >> ms: ms [

	^ self new
		  ms: ms;
		  yourself
]

{ #category : 'api' }
PhxPjDebouncer >> do: aBlock [

	handle ifNotNil: [ PhxPjTimer clearTimeoutWithHandle: handle ].
	handle := PhxPjTimer afterMilliseconds: self ms do: [
		handle := nil.
		aBlock value ]
]

{ #category : 'api' }
PhxPjDebouncer >> doLeading: aBlock [

	handle ifNil: [
		aBlock value.
		handle := PhxPjTimer afterMilliseconds: self ms do: [ handle := nil ].
		^ self ].

	^ self do: aBlock
]

{ #category : 'accessing' }
PhxPjDebouncer >> ms [

	^ ms
]

{ #category : 'accessing' }
PhxPjDebouncer >> ms: anObject [

	ms := anObject
]
