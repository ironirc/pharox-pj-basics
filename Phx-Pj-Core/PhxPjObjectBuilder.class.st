"
Sending jsObj to the block initiates building the js object.
Little downside => we have to take argument :x at the beginning of the block to obtain the builder.
Sending jsFunc to a block, keeps the block/function preserved.
This currently only works in JS world.

```
	obj := [ :x |
	       x
		       person: [
			       x
				       fullName: 'Alice Smith';
				       shoeSize: 38;
				       isFunny: true;
				       dateOfBirth: '1990-05-15';
				       prefs: {
						       [ x shirtColor: 'blue' ].
						       [ x favouriteFood: 'pizza' ] };
				       hobbies: { 'reading'. 'painting' } ];
		       onNewsMessageDo: [ :message | 'Sending Alice a news message: ' , message ] jsFunc ] jsObj
```
"
Class {
	#name : 'PhxPjObjectBuilder',
	#superclass : 'PjDomController',
	#instVars : [
		'stack'
	],
	#category : 'Phx-Pj-Core',
	#package : 'Phx-Pj-Core'
}

{ #category : 'examples' }
PhxPjObjectBuilder class >> buildCollection: aBlock [
	^ self new buildCollection: aBlock
]

{ #category : 'examples' }
PhxPjObjectBuilder class >> buildObject: aBlock [
	^ self new buildObject: aBlock
]

{ #category : 'examples' }
PhxPjObjectBuilder class >> example1 [
	^{('content'
		->
			{{('text' -> 'example text 1').
			('style' -> 'header')}.
			{('text'
				->
					{'Text2a'.
					'Text2b'.
					{('text' -> 'Text3b').
					('fontSize' -> 15).
					('bold' -> true)}})}})} asJsObject
]

{ #category : 'examples' }
PhxPjObjectBuilder class >> example2 [

	^ self buildObject: [ :x |
		  x at: 'content' buildCollection: [
			  x buildObject: [
				  x at: 'text' put: 'example text 1'.
				  x at: 'style' put: 'header' ].
			  x buildObject: [
				  x at: 'text' buildCollection: [
					  x add: 'Text2a'.
					  x add: 'Text2b' ] ] ] ]
]

{ #category : 'examples' }
PhxPjObjectBuilder class >> with: aCollection buildCollection: aBlock [

	^(self new)
		with: aCollection buildCollection: aBlock
]

{ #category : 'examples' }
PhxPjObjectBuilder class >> with: aCollection buildObject: aBlock [

	^(self new)
		with: aCollection buildObject: aBlock
]

{ #category : 'examples' }
PhxPjObjectBuilder >> add: anObject [
	(self stackTopValue isKindOf: OrderedCollection)
		ifTrue: [ self stackTopValue add: (anObject) ]
]

{ #category : 'reflective operations' }
PhxPjObjectBuilder >> at: aKey buildCollection: aBlock [

	self at: aKey put: (self buildCollection: aBlock)
]

{ #category : 'reflective operations' }
PhxPjObjectBuilder >> at: aKey buildObject: aBlock [
	self at: aKey put: (self buildObject: aBlock)
]

{ #category : 'reflective operations' }
PhxPjObjectBuilder >> at: aKey put: anObject [

	self stackTopValue at: aKey put: (self valueFor: anObject)
]

{ #category : 'reflective operations' }
PhxPjObjectBuilder >> at: key with: aCollection buildCollection: aBlock [
	self stackTopValue
		at: key
		put: (self with: aCollection buildCollection: aBlock)
]

{ #category : 'reflective operations' }
PhxPjObjectBuilder >> at: key with: anObject buildObject: aBlock [
	self stackTopValue
		at: key
		put:
			(anObject
				ifNotNil: [ self with: anObject buildObject: aBlock ]
				ifNil: [ nil ])
]

{ #category : 'public' }
PhxPjObjectBuilder >> buildCollection: aBlock [

	^ aBlock isBlock
		  ifFalse: [ self valueFor: aBlock ]
		  ifTrue: [
			  | resultCollection |
			  resultCollection := OrderedCollection new.
			  stack add: 'building collection' -> resultCollection.
			  aBlock cull: self.
			  stack removeLast.
			  self isBuildingCollection ifTrue: [
				  self stackTopValue add: resultCollection ].
			  resultCollection ]
]

{ #category : 'reflective operations' }
PhxPjObjectBuilder >> buildObject: aBlock [

	| object blockResult |
	object := Object new.
	stack add: 'building object' -> object.
	blockResult := aBlock cull: self.
	stack removeLast.
	self isBuildingCollection ifTrue: [ self stackTopValue add: object ].
	^ blockResult isCollection
		  ifTrue: [ blockResult collect: [ :e | self valueFor: e ] ]
		  ifFalse: [ object ]
]

{ #category : 'public' }
PhxPjObjectBuilder >> doesNotUnderstand: aMessage [

	| key |
	key := aMessage selector.
	(self isKeyword: key) ifTrue: [
		key := key allButLast asSymbol.
		self at: key put: aMessage arguments first.
		^ self ].
	^ super doesNotUnderstand: aMessage
]

{ #category : 'initialize' }
PhxPjObjectBuilder >> initialize [
	stack := OrderedCollection new
]

{ #category : 'reflective operations' }
PhxPjObjectBuilder >> isBuildingCollection [
	^ self stackTopKey = 'building collection'
]

{ #category : 'public' }
PhxPjObjectBuilder >> isKeyword: aKey [

	^ (aKey endsWith: ':') 
]

{ #category : 'private' }
PhxPjObjectBuilder >> stackTopKey [
	stack ifNilOrEmpty: [^nil].
	^stack last key
]

{ #category : 'private' }
PhxPjObjectBuilder >> stackTopValue [
	stack ifNilOrEmpty: [^nil].
	^stack last value
]

{ #category : 'public' }
PhxPjObjectBuilder >> valueFor: anObject [

	anObject isBlock ifTrue: [
		anObject isMarkedAsFunction ifTrue: [ ^ anObject ].
		^ self buildObject: anObject ].
	anObject isString ifTrue: [ ^ anObject ].
	anObject isCollection ifTrue: [
		^ anObject collect: [ :e | self valueFor: e ] ].
	^ anObject
]

{ #category : 'public' }
PhxPjObjectBuilder >> with: sourceCollection buildCollection: aBlock [
	^ self
		collection:
			[ sourceCollection do: [ :each | self with: each buildObject: aBlock ] ]
]

{ #category : 'reflective operations' }
PhxPjObjectBuilder >> with: aSourceObject buildObject: aBlockOrValue [
	^ self buildObject: [ aBlockOrValue cull: aSourceObject cull: self ]
]
