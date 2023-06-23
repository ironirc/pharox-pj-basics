Class {
	#name : #PhxPjConsole,
	#superclass : #PjDomController,
	#category : #'Phx-Pj-Core-Traits'
}

{ #category : #testing }
PhxPjConsole class >> logAll: args [

	<javascript: 'console.log(...args)'>
]
