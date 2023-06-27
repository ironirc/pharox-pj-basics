Class {
	#name : #PjDomBuilder,
	#superclass : #PjDomController,
	#traits : 'DomBuilderTrait',
	#classTraits : 'DomBuilderTrait classTrait',
	#category : #'Phx-Pj-Dom-Builder'
}

{ #category : #text }
PjDomBuilder >> createTextNode: aString [

	^document createTextNode: aString
]
