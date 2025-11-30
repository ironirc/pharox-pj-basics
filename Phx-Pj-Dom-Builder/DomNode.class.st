Class {
	#name : 'DomNode',
	#superclass : 'Object',
	#instVars : [
		'attributes',
		'classList',
		'styles',
		'children',
		'tagName',
		'innerHTML'
	],
	#category : 'Phx-Pj-Dom-Builder',
	#package : 'Phx-Pj-Dom-Builder'
}

{ #category : 'instance creation' }
DomNode class >> new [

	self error: 'use #newNamed: instead'
]

{ #category : 'instance creation' }
DomNode class >> newNamed: aName [
"
self newNamed: 'div'
"
	^ super new
		  tagName: aName;
		  yourself
]

{ #category : 'accessing' }
DomNode >> appendChild: aChild [

	children add: aChild
]

{ #category : 'accessing' }
DomNode >> attributes [

	^ attributes
]

{ #category : 'accessing' }
DomNode >> attributes: anObject [

	attributes := anObject
]

{ #category : 'accessing' }
DomNode >> children [

	^ children
]

{ #category : 'accessing' }
DomNode >> children: anObject [

	children := anObject
]

{ #category : 'accessing' }
DomNode >> classList [

	^ classList
]

{ #category : 'accessing' }
DomNode >> classList: anObject [

	classList := anObject
]

{ #category : 'accessing' }
DomNode >> getHtml [

	^ String streamContents: [ :ws | self streamChildrenOn: ws ]
]

{ #category : 'initialize - release' }
DomNode >> initialize [

	attributes := OrderedDictionary new.
	classList := OrderedCollection new.
	styles := OrderedDictionary new.
	children := OrderedCollection new
]

{ #category : 'accessing' }
DomNode >> innerHTML [

	^ innerHTML ifNil: [ '']
]

{ #category : 'accessing' }
DomNode >> innerHTML: anObject [

	innerHTML := anObject
]

{ #category : 'initialize - release' }
DomNode >> printOn: ws [

	ws << '{' << tagName << '}'
]

{ #category : 'accessing' }
DomNode >> setAttribute: aKey to: aValue [

	attributes at: aKey put: aValue
]

{ #category : 'accessing' }
DomNode >> streamChildrenOn: ws [

	self children do: [ :el | el streamHtmlOn: ws ]
]

{ #category : 'accessing' }
DomNode >> streamHtmlOn: ws [

	ws << '<' << tagName.
	classList ifNotEmpty: [ 
		ws space.
		ws << 'class="'.
		classList do: [ :each | ws << each ] separatedBy: [ ws space ].
		ws << '"' ].
	attributes keysAndValuesDo: [ :k :v | 
		ws space.
		ws << k << '="' << v << '"' ].
	styles ifNotEmpty: [ 
		ws space.
		ws << 'style="'.
		styles keysAndValuesDo: [ :k :v | 
			ws space.
			ws << k << '="' << v << '"' ].
		ws < ';"' ].
	ws << '>'.
	ws << self innerHTML.
	self streamChildrenOn: ws.
	ws << '</' << tagName << '>'
]

{ #category : 'accessing' }
DomNode >> styles [

	^ styles
]

{ #category : 'accessing' }
DomNode >> styles: anObject [

	styles := anObject
]

{ #category : 'accessing' }
DomNode >> tagName [

	^ tagName
]

{ #category : 'accessing' }
DomNode >> tagName: anObject [

	tagName := anObject
]
