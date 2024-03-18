Trait {
	#name : #DomBuilderTrait,
	#instVars : [
		'currentComponent',
		'currentElement'
	],
	#category : #'Phx-Pj-Dom-Builder'
}

{ #category : #'instance creation' }
DomBuilderTrait classSide >> newOnElement: anElement [
	^ self new
		currentElement: anElement;
		yourself
]

{ #category : #text }
DomBuilderTrait >> << aString [

	"anObject isBlock
		ifTrue: [ self reactivelySetTextContentWith: anObject ]
		ifFalse: [ self currentElement
				textContent: self currentElement textContent , anObject value ]"

	aString isString ifFalse: [ 
		self error: 'message #<< expects a string' ].
	"	self currentElement
		innerHTML: self currentElement innerHTML , aString"
	self currentElement appendChild: (self createTextNode: aString)
]

{ #category : #attribute }
DomBuilderTrait >> __privateAtAttribute: aName put: anObject [

	anObject ifNil: [ ^ self ].
	anObject
		ifNil: [ self removeAttribute: aName ofElement: self currentElement ]
		ifNotNil: [ 
		self attribute: aName ofElement: self currentElement set: anObject ]
]

{ #category : #'comp-props' }
DomBuilderTrait >> __privateAtProperty: aName put: aValue [
	currentComponent propertyAt: aName put: aValue
]

{ #category : #'comp-accessing' }
DomBuilderTrait >> __privateAtSlot: aSlotName put: aBlock [
	currentComponent atSlot: aSlotName put: aBlock
]

{ #category : #'attribute-class' }
DomBuilderTrait >> _addClass: aClass [ 
	self _addClass: aClass toElement: self currentElement
]

{ #category : #'attribute-class' }
DomBuilderTrait >> _addClass: aClass toElement: anElement [
	anElement classList add: aClass
]

{ #category : #'attribute-class' }
DomBuilderTrait >> _addClassesInString: aString [
	self wordsInString: aString do: [ :each | self _addClass: each ]
]

{ #category : #'attribute-class' }
DomBuilderTrait >> _addClassesInString: aString toElement: anElement [
	self wordsInString: aString do: [ :each | self _addClass: each toElement: anElement ]
]

{ #category : #attribute }
DomBuilderTrait >> _attr: anObject [
	anObject phxBuildDomNodeAttributesOn: self
	
]

{ #category : #'attribute-class' }
DomBuilderTrait >> _class: anObject [
	anObject phxBuildDomNodeClassesOn: self
]

{ #category : #'attribute-class' }
DomBuilderTrait >> _class: classesString if: aBoolean [

	aBoolean
		ifTrue: [ self _addClassesInString: classesString ]
		ifFalse: [ self _removeClassesInString: classesString ]
]

{ #category : #debug }
DomBuilderTrait >> _debugTs [
	self div: [ self << DateAndTime now printString ]
]

{ #category : #text }
DomBuilderTrait >> _html: aString [ 

	self currentElement innerHTML: self currentElement innerHTML , aString 
]

{ #category : #attribute }
DomBuilderTrait >> _id: anId [
	self __privateAtAttribute: 'id' put: anId
]

{ #category : #'native event listeners' }
DomBuilderTrait >> _on: anEventName do: aBlock [
	self currentElement addEventListener: anEventName block: aBlock
]

{ #category : #'attribute-style' }
DomBuilderTrait >> _privateAtStyle: aStyleName put: anObject [

	self currentElement style at: aStyleName put: anObject
]

{ #category : #'comp-props' }
DomBuilderTrait >> _prop: anObject [
	anObject phxBuildComponentPropertiesOn: self
]

{ #category : #'attribute-class' }
DomBuilderTrait >> _removeClass: aClass [ 
	self _removeClass: aClass fromElement: self currentElement
]

{ #category : #'attribute-class' }
DomBuilderTrait >> _removeClass: aClass fromElement: anElement [
	anElement classList remove: aClass
]

{ #category : #'attribute-class' }
DomBuilderTrait >> _removeClassesInString: aString [
	self wordsInString: aString do: [ :each | self _removeClass: each ]
]

{ #category : #'attribute-class' }
DomBuilderTrait >> _removeClassesInString: aString fromElement: anElement [
	self
		wordsInString: aString
		do: [ :each | self _removeClass: each fromElement: anElement ]
]

{ #category : #'comp-accessing' }
DomBuilderTrait >> _slot: anObject [
	anObject phxBuildComponentSlotsOn: self
]

{ #category : #text }
DomBuilderTrait >> _stream: aBlock [

	aBlock isBlock ifFalse: [ 
		self error: '#_stream: only takes a 1 arg block as argument' ].
	self currentElement textContent: [ 
		String streamContents: [ :ws | aBlock value: ws ] ]
]

{ #category : #'attribute-style' }
DomBuilderTrait >> _style: anObject [
	anObject phxBuildDomNodeStylesOn: self
]

{ #category : #text }
DomBuilderTrait >> _text: anObject [

	self currentElement textContent: anObject value
]

{ #category : #element }
DomBuilderTrait >> a: aBlockOrString [
	self tag: 'a' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> audio: aBlockOrString [
	self tag: 'audio' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> br [
	self _html: '<br>'
]

{ #category : #element }
DomBuilderTrait >> button: aBlockOrString [
	self tag: 'button' with: aBlockOrString
]

{ #category : #comp }
DomBuilderTrait >> comp: aComponentClass at: aKey config: aBlock [

	"instantiate, configure and render a component"

	| theComp |
	theComp := currentComponent
		           comp: aComponentClass
		           at: aKey
		           config: [ :newComp | 
			           | prev |
			           prev := currentComponent.
			           currentComponent := newComp.
			           [ aBlock cull: newComp ] ensure: [ 
				           currentComponent := prev ].
			           self ].
	self renderComp: theComp
]

{ #category : #comp }
DomBuilderTrait >> comp: aComponentClass config: aBlock [

	self comp: aComponentClass at: nil config: aBlock
]

{ #category : #private }
DomBuilderTrait >> currentElement [
	^currentElement
]

{ #category : #private }
DomBuilderTrait >> currentElement: anElement [
	currentElement := anElement
]

{ #category : #element }
DomBuilderTrait >> div: aBlockOrString [
	self tag: 'div' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> form: aBlockOrString [
	self tag: 'form' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> h1: aBlockOrString [
	self tag: 'h1' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> h2: aBlockOrString [
	self tag: 'h2' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> h3: aBlockOrString [
	self tag: 'h3' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> h4: aBlockOrString [
	self tag: 'h4' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> h5: aBlockOrString [
	self tag: 'h5' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> h6: aBlockOrString [
	self tag: 'h6' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> header: aBlockOrString [
	self tag: 'header' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> i: aBlockOrString [
	self tag: 'i' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> iframe: aBlockOrString [
	self tag: 'iframe' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> img: aBlockOrString [
	self tag: 'img' with: aBlockOrString
]

{ #category : #'initialize-release' }
DomBuilderTrait >> initialComponent: anObject [
	currentComponent
		ifNotNil: [ self error: 'illegal to reassign component' ].
	currentComponent := anObject
]

{ #category : #'initialize-release' }
DomBuilderTrait >> initialize [ 
	"elements := OrderedCollection new."
]

{ #category : #element }
DomBuilderTrait >> input: aString [
	self tag: 'input' with: aString
]

{ #category : #element }
DomBuilderTrait >> label: aString [
	self tag: 'label' with: aString
]

{ #category : #element }
DomBuilderTrait >> li: aBlockOrString [
	self tag: 'li' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> main: aBlockOrString [
	self tag: 'main' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> nav: aBlockOrString [
	self tag: 'nav' with: aBlockOrString
]

{ #category : #'native event listeners' }
DomBuilderTrait >> onBlur: aBlock [
	self currentElement addEventListener: #blur block: aBlock
]

{ #category : #'native event listeners' }
DomBuilderTrait >> onChange: aBlock [
	self currentElement addEventListener: #change block: aBlock
]

{ #category : #'native event listeners' }
DomBuilderTrait >> onClick: aBlock [
	self currentElement addEventListener: #click block: aBlock
]

{ #category : #'native event listeners' }
DomBuilderTrait >> onClick_capturePhase: aBlock [ 
	"no senders yet"
	self currentElement addEventListener: #click block: aBlock with: true
]

{ #category : #'native event listeners' }
DomBuilderTrait >> onContextMenu: aBlock [
	self currentElement addEventListener: #contextmenu block: aBlock
]

{ #category : #'native event listeners' }
DomBuilderTrait >> onDrag: aBlock [
	self currentElement addEventListener: #drag block: aBlock
]

{ #category : #'native event listeners' }
DomBuilderTrait >> onFocus: aBlock [
	self currentElement addEventListener: #focus block: aBlock
]

{ #category : #'native event listeners' }
DomBuilderTrait >> onFocusIn: aBlock [
	self currentElement addEventListener: #focusin block: aBlock
]

{ #category : #'native event listeners' }
DomBuilderTrait >> onFocusOut: aBlock [
	self currentElement addEventListener: #focusout block: aBlock
]

{ #category : #'native event listeners' }
DomBuilderTrait >> onInput: aBlock [
	self currentElement addEventListener: #input block: aBlock
]

{ #category : #'native event listeners' }
DomBuilderTrait >> onKeyDown: aBlock [
	self currentElement addEventListener: #keydown block: aBlock
]

{ #category : #'native event listeners' }
DomBuilderTrait >> onKeyPress: aBlock [
	self currentElement addEventListener: #keypress block: aBlock
]

{ #category : #'native event listeners' }
DomBuilderTrait >> onKeyUp: aBlock [
	self currentElement addEventListener: #keyup block: aBlock
]

{ #category : #'native event listeners' }
DomBuilderTrait >> onMouseDown: aBlock [
	self currentElement addEventListener: #mousedown block: aBlock
]

{ #category : #'native event listeners' }
DomBuilderTrait >> onMouseEnter: aBlock [
	self currentElement addEventListener: #mouseenter block: aBlock
]

{ #category : #'native event listeners' }
DomBuilderTrait >> onMouseLeave: aBlock [
	self currentElement addEventListener: #mouseleave block: aBlock
]

{ #category : #'native event listeners' }
DomBuilderTrait >> onMouseMove: aBlock [
	self currentElement addEventListener: #mousemove block: aBlock
]

{ #category : #'native event listeners' }
DomBuilderTrait >> onMouseOut: aBlock [
	self currentElement addEventListener: #mouseout block: aBlock
]

{ #category : #'native event listeners' }
DomBuilderTrait >> onMouseOver: aBlock [
	self currentElement addEventListener: #mouseover block: aBlock
]

{ #category : #'native event listeners' }
DomBuilderTrait >> onMouseUp: aBlock [
	self currentElement addEventListener: #mouseup block: aBlock
]

{ #category : #'native event listeners' }
DomBuilderTrait >> onSelect: aBlock [
	self currentElement addEventListener: #select block: aBlock
]

{ #category : #element }
DomBuilderTrait >> option: aBlockOrString [
	self tag: 'option' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> p: aBlockOrString [
	self tag: 'p' with: aBlockOrString
]

{ #category : #comp }
DomBuilderTrait >> renderComp: aComponent [
	"self
		log:
			{'renderComp:'.
			aComponent class name.
			aComponent compId.
			aComponent ensuredContainingElement.
			'appending as child'}."
	self currentElement appendChild: aComponent ensuredContainingElement.
	aComponent rebuild. 
	"aComponent onShow."
]

{ #category : #element }
DomBuilderTrait >> script: aBlockOrString [
	self tag: 'script' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> section: aBlockOrString [
	self tag: 'section' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> select: aBlockOrString [
	self tag: 'select' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> slot: aBlockOrString [
	self tag: 'slot' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> small: aBlockOrString [
	self tag: 'small' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> source: aBlockOrString [
	self tag: 'source' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> span: aBlockOrString [
	self tag: 'span' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> strong: aBlockOrString [
	self tag: 'strong' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> style: aBlockOrString [
	self tag: 'style' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> sub: aBlockOrString [
	self tag: 'sub' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> sup: aBlockOrString [
	self tag: 'sup' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> svg: aBlockOrString [
	self tag: 'svg' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> table: aBlockOrString [
	self tag: 'table' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> tag: tag with: aBlockOrString [

	"2023-03-19 Major change: Now first creates the new element, then completely builds it, and then adds it to current element"

	| el |
	el := self createElement: tag.
	self
		useCurrentElement: el
		while: [ aBlockOrString phxBuildDomNodeOn: self ].
	self currentElement appendChild: el.
	^ el
]

{ #category : #element }
DomBuilderTrait >> tbody: aBlockOrString [
	self tag: 'tbody' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> td: aBlockOrString [
	self tag: 'td' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> textArea: aString [
	self tag: 'textarea' with: aString
]

{ #category : #element }
DomBuilderTrait >> textarea: aBlockOrString [
	self tag: 'textarea' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> th: aBlockOrString [
	self tag: 'th' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> thead: aBlockOrString [
	self tag: 'thead' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> title: aBlockOrString [
	self tag: 'title' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> tr: aBlockOrString [
	self tag: 'tr' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> ul: aBlockOrString [
	self tag: 'ul' with: aBlockOrString
]

{ #category : #element }
DomBuilderTrait >> useCurrentElement: anElement while: aBlock [
	| prev |
	prev := currentElement.
	currentElement := anElement.
	aBlock
		ensure: [ currentElement := prev ]
]

{ #category : #actions }
DomBuilderTrait >> wipeCurrentElement [
	self currentElement innerHTML: ''
]

{ #category : #'attribute-class' }
DomBuilderTrait >> wordsInString: aString do: aBlock [

	(' ' split: aString) do: [ :each | 
		(each notNil and: [ each isEmpty not ]) ifTrue: [ 
			aBlock value: each ] ]
]
