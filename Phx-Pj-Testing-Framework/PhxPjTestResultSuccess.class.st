Class {
	#name : 'PhxPjTestResultSuccess',
	#superclass : 'PhxPjAbstractTestResult',
	#category : 'Phx-Pj-Testing-Framework',
	#package : 'Phx-Pj-Testing-Framework'
}

{ #category : 'rendering' }
PhxPjTestResultSuccess >> cssOn: eb [  

	eb _class: 'test-case-success'
]
