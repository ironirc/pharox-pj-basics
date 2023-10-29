Class {
	#name : #PhxSpaAbstractMessageNoResponse,
	#superclass : #PhxSpaAbstractMessage,
	#category : #'Phx-Pj-Client-Server-shared'
}

{ #category : #testing }
PhxSpaAbstractMessageNoResponse >> expectsResponseFromClient [ 
	^false
]
