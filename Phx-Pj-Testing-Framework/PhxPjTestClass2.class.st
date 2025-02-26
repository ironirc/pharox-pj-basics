Class {
	#name : 'PhxPjTestClass2',
	#superclass : 'Object',
	#instVars : [
		'bar'
	],
	#category : 'Phx-Pj-Testing-Framework',
	#package : 'Phx-Pj-Testing-Framework'
}

{ #category : 'as yet unclassified' }
PhxPjTestClass2 class >> clsBar [

	^'clsBar'
]

{ #category : 'as yet unclassified' }
PhxPjTestClass2 >> bar [ 
	^bar ,  'World'
]

{ #category : 'accessing' }
PhxPjTestClass2 >> initialize [ 

	bar := 'Dummy'
]
