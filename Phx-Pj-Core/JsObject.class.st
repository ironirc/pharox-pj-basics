Class {
	#name : 'JsObject',
	#superclass : 'Object',
	#category : 'Phx-Pj-Core-Unused',
	#package : 'Phx-Pj-Core',
	#tag : 'Unused'
}

{ #category : 'accessing' }
JsObject >> asPlainObject [
	<javascript: 'return {...this  }'>
]

{ #category : 'accessing' }
JsObject >> at: aKey [

	"make it work more like javascript objects"
	^ self at: aKey ifAbsent: [nil]
]

{ #category : 'as yet unclassified' }
JsObject >> doesNotUnderstand: aMessage [
	| key |
	key := aMessage selector.
	(self isUnaryKey: key) ifTrue: [^ self at: key].
	 ((self isKeyword: key) "and: [(key occurrencesOf: $:) = 1]")
		ifTrue: [key := key allButLast asSymbol.
				self at: key put: aMessage arguments first]
		ifFalse: [super doesNotUnderstand: aMessage]
				
	
]

{ #category : 'as yet unclassified' }
JsObject >> isKeyword: aKey [

	^ (aKey endsWith: ':') 
]

{ #category : 'as yet unclassified' }
JsObject >> isUnaryKey: aKey [

	^ (aKey endsWith: ':') not
]

{ #category : 'accessing' }
JsObject >> name [
"override 'cause Object defines this"
	^self at: 'name'
]

{ #category : 'accessing' }
JsObject >> value [
"override 'cause Object defines this"
	^self at: 'value'
]
