Class {
	#name : #PjWcCounter,
	#superclass : #PjWebComponent,
	#instVars : [
		'count',
		'countElement'
	],
	#category : #'Phx-Pj-Web-Components'
}

{ #category : #'as yet unclassified' }
PjWcCounter class >> tagName [

	^ 'pj-counter'
]

{ #category : #initialization }
PjWcCounter >> initialize [

	count := 0
]

{ #category : #initialization }
PjWcCounter >> renderOn: x [

	x tag: 'style' with: '* {color:blue;}'.
	x div: [ x slot: '' ].
	x div: [ 
		x button: [ 
			x onClick: [ 
				count := count - 1.
				countElement innerHTML: count ].
			x << '-' ].
		x span: [ :el | 
			countElement := el.
			el style margin: '5px'.
			el innerHTML: count ].

		x button: [ 
			x onClick: [ 
				count := count + 1.
				countElement innerHTML: count ].
			x << '+' ] ]
]
