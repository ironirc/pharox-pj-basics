Class {
	#name : 'PhxPjTestClass1',
	#superclass : 'Object',
	#instVars : [
		'foo'
	],
	#classInstVars : [
		'var'
	],
	#category : 'Phx-Pj-Testing-Framework',
	#package : 'Phx-Pj-Testing-Framework'
}

{ #category : 'as yet unclassified' }
PhxPjTestClass1 class >> clsFoo [ 

	^'clsFoo'
]

{ #category : 'as yet unclassified' }
PhxPjTestClass1 class >> clsVar [

	^var
]

{ #category : 'as yet unclassified' }
PhxPjTestClass1 class >> initialize [ 

	var := 'var'
]

{ #category : 'as yet unclassified' }
PhxPjTestClass1 >> foo [ 
	^foo
]

{ #category : 'accessing' }
PhxPjTestClass1 >> initialize [ 

	foo := 'Hello'
]
