Class {
	#name : #PjWebComponent,
	#superclass : #PjHTMLElement,
	#instVars : [
		'_privateState'
	],
	#category : #'Phx-Pj-Web-Components'
}

{ #category : #'as yet unclassified' }
PjWebComponent class >> allSubclassesDo: aBlock [ 
	"Evaluate the argument, aBlock, for each of the receiver's subclasses."

	self subclasses do: 
		[:cl | 
		aBlock value: cl.
		cl allSubclassesDo: aBlock]
]

{ #category : #'as yet unclassified' }
PjWebComponent class >> initialize [
	"Initialize gets executed at class load time. We need something that executes only in js"
	<javascript: 'this.pj_initializeInJsOnly()'>

]

{ #category : #'as yet unclassified' }
PjWebComponent class >> initializeInJsOnly [

	"May be explicit initialization would be better, though this is convenient"

	self allSubclassesDo:  [ :sc | 
		sc isAbstract ifFalse: [ sc registerAsComponent ] ]
]

{ #category : #'as yet unclassified' }
PjWebComponent class >> isAbstract [

	^ self = PjWebComponent
]

{ #category : #'as yet unclassified' }
PjWebComponent class >> jsInstantiate: aClass [

	<javascript: 'return new aClass'>
]

{ #category : #'as yet unclassified' }
PjWebComponent class >> new [

	^ self jsInstantiate: self
]

{ #category : #'as yet unclassified' }
PjWebComponent class >> registerAsComponent [
	"This step is necessary for accessing the desired HTML element, 
	regardless of whether it is used by tag name (in html) or through normal instantiation (dom)"
	window customElements define: self tagName with: self
]

{ #category : #'as yet unclassified' }
PjWebComponent class >> tagName [

	"self subclassResponsibility"
]

{ #category : #'web component callbacks' }
PjWebComponent >> _privateConnected [

	
]

{ #category : #'web component callbacks' }
PjWebComponent >> connected [


]

{ #category : #'web component callbacks' }
PjWebComponent >> connectedCallback [

	"jsAlias: ensures a secondary method in js with given name
	(besides the normal transpiled 'pj_connectedCallback'). "

	<jsAlias: 'connectedCallback'>
	self _privateConnected.
	self connected
]

{ #category : #private }
PjWebComponent >> htmlBuilderClass [

	^ PjDomBuilder
]

{ #category : #rendering }
PjWebComponent >> initialRenderOn: x [ 

	self renderOn: x
]

{ #category : #initialization }
PjWebComponent >> initialize [

	_privateState ifNil: [ _privateState := Object new ]
]

{ #category : #initialization }
PjWebComponent >> js_constructor [
	"The 'js_' prefix ensures that the constructor method gets transpiled without the 'pj_' prefix."
	"The method body directly delegates to 'self constructer' (hence the pj_ prefix there)"
	<javascript: 'super(); this.pj_privateConstruct()'>
]

{ #category : #private }
PjWebComponent >> newBuilder [
	^ self htmlBuilderClass newOnElement: self shadowRoot
]

{ #category : #initialization }
PjWebComponent >> privateConstruct [
	self initialize.
	self attachShadow: { ('mode' -> 'open') } asJsObject.
	self initialRenderOn: self newBuilder
]

{ #category : #accessing }
PjWebComponent >> privateStateAt: aSymbol [
	^ _privateState  at: aSymbol
]

{ #category : #accessing }
PjWebComponent >> privateStateAt: aSymbol put: anObject [

	_privateState at: aSymbol put: anObject
]

{ #category : #rendering }
PjWebComponent >> renderOn: x [ 

	
]
