Class {
	#name : 'DomBuilder',
	#superclass : 'Object',
	#traits : 'DomBuilderTrait',
	#classTraits : 'DomBuilderTrait classTrait',
	#category : 'Phx-Pj-Dom-Builder',
	#package : 'Phx-Pj-Dom-Builder'
}

{ #category : 'text' }
DomBuilder >> _html: aString [
	"Unlike in browser, setting innerHTML doesn't instantly converts to 'children'"
	self << aString
]

{ #category : 'attribute' }
DomBuilder >> attribute: attributeName ofElement: domElement set: attributeValue [
	domElement setAttribute: attributeName to: attributeValue
]

{ #category : 'element' }
DomBuilder >> createElement: tagString [ 
	^DomNode newNamed: tagString
]

{ #category : 'element' }
DomBuilder >> createElement: tagString namespace: aNamespace [
	self error: 'To be implemented'.
	^DomNode newNamed: tagString
]

{ #category : 'element' }
DomBuilder >> createTextNode: aString [

	^DomTextNode new: aString
]

{ #category : 'attribute' }
DomBuilder >> removeAttribute: attributeName ofElement: domElement [
	^domElement removeAttribute: attributeName
]
