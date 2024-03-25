Class {
	#name : #PhxPjDebouncer,
	#superclass : #PjDomController,
	#instVars : [
		'ms',
		'handle'
	],
	#category : #'Phx-Pj-Core-Support'
}

{ #category : #accessing }
PhxPjDebouncer class >> ms: ms [

	^ self new
		  ms: ms;
		  yourself
]

{ #category : #accessing }
PhxPjDebouncer >> do: aBlock [

	handle ifNotNil: [ PhxPjTimer clearInterval: handle ].
	handle := PhxPjTimer afterMilliseconds: self ms do: aBlock
]

{ #category : #accessing }
PhxPjDebouncer >> ms [

	^ ms
]

{ #category : #accessing }
PhxPjDebouncer >> ms: anObject [

	ms := anObject
]
