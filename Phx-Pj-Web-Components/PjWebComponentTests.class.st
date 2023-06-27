Class {
	#name : #PjWebComponentTests,
	#superclass : #PjBridgeTestCase,
	#category : #'Phx-Pj-Web-Components'
}

{ #category : #tests }
PjWebComponentTests >> test1 [

	self assert: [ PjWcCounter tagName ] evaluatesTo: 'pj-counter'.
	self assert: [ PjWcCounter new count ] evaluatesTo: 0.
	self
		assert: [ 
			| dc div ctrEl|
			dc := PjDomController new.
			div := dc addElement: 'div'.
			ctrEl := dc addElement: PjWcCounter tagName to: div.
			ctrEl textContent: 'Awesome counter'.
			div innerHTML ]
		evaluatesTo: '<pj-counter>Awesome counter</pj-counter>'
]
