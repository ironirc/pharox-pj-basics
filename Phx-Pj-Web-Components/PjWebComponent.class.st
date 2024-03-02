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
	self error: 'can''t be instantiated in Smalltalk, only in JS'
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

{ #category : #initialization }
PjWebComponent >> connected [

	self hasBeenConnected
		ifFalse: [ self connectedForFirstTime ]
		ifTrue: [ self connectedAgain ]
]

{ #category : #initialization }
PjWebComponent >> connectedAgain [
	console log: 'connectedAgain: ' with: self.
	"self logSelfAndAll: { '#connectedAgain' }"
]

{ #category : #'web component callbacks' }
PjWebComponent >> connectedCallback [
	"jsAlias: ensures a secondary method in js with given name
	(besides the normal transpiled 'pj_connectedCallback'). "

	<jsAlias: 'connectedCallback'>
	console log: 'connectedCallback: ' with: self.
	self _privateConnected.
	self connected
]

{ #category : #initialization }
PjWebComponent >> connectedForFirstTime [
	console log: 'connectedForFirstTime: ' with: self.
	self hasBeenConnected: true.
	self render. 
	"self logSelfAndAll: { '#connectedForFirstTime' }"
]

{ #category : #private }
PjWebComponent >> domBuilderClass [

	^ PjDomBuilder
]

{ #category : #accessing }
PjWebComponent >> hasBeenConnected [

	^ (self psAt: #hasBeenConnected) == true
]

{ #category : #accessing }
PjWebComponent >> hasBeenConnected: aBoolean [

	self psAt: #hasBeenConnected put: aBoolean
]

{ #category : #rendering }
PjWebComponent >> initialRenderOn: x [ 
	console log: 'initialRenderOn:' with: self. 
	x wipeCurrentElement . 
	self renderOn: x
]

{ #category : #initialization }
PjWebComponent >> initialize [
	_privateState ifNil: [ _privateState := Object new ].
	self attachShadow: { ('mode' -> 'open') } asJsObject.


]

{ #category : #private }
PjWebComponent >> newBuilder [
	^ self domBuilderClass newOnElement: self shadowRoot
]

{ #category : #accessing }
PjWebComponent >> privateStateAt: aSymbol [
	^ _privateState  at: aSymbol
]

{ #category : #accessing }
PjWebComponent >> privateStateAt: aSymbol put: anObject [

	_privateState at: aSymbol put: anObject
]

{ #category : #accessing }
PjWebComponent >> psAt: aSymbol [

	^ _privateState at: aSymbol
]

{ #category : #accessing }
PjWebComponent >> psAt: aSymbol put: aValue [

	^ _privateState at: aSymbol put: aValue
]

{ #category : #initialization }
PjWebComponent >> render [

	self initialRenderOn: self newBuilder
]

{ #category : #rendering }
PjWebComponent >> renderOn: x [ 

	
]
