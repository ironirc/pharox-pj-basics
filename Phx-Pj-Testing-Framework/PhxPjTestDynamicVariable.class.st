Class {
	#name : #PhxPjTestDynamicVariable,
	#superclass : #PhxPjAbstractTestCase,
	#category : #'Phx-Pj-Testing-Framework'
}

{ #category : #tests }
PhxPjTestDynamicVariable >> testDynamicVariable [

	self assert: PhxPjDynamicVariable value equals: nil.
	PhxPjDynamicVariable value: 42 during: [
		1 to: 100 do: [ :i | i * 3 ].
		self assert: PhxPjDynamicVariable value equals: 42 ]
]
