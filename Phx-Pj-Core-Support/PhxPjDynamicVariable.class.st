Class {
	#name : 'PhxPjDynamicVariable',
	#superclass : 'PjDomController',
	#classVars : [
		'Value'
	],
	#category : 'Phx-Pj-Core-Support',
	#package : 'Phx-Pj-Core-Support'
}

{ #category : 'accessing' }
PhxPjDynamicVariable class >> value [

	^ Value
]

{ #category : 'accessing' }
PhxPjDynamicVariable class >> value: aValue during: aBlock [

	| oldValue |
	oldValue := self value.
	Value := aValue.
	aBlock ensure: [ Value := oldValue ]
]
