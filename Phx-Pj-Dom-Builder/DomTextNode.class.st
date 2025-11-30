Class {
	#name : 'DomTextNode',
	#superclass : 'Object',
	#instVars : [
		'text'
	],
	#category : 'Phx-Pj-Dom-Builder',
	#package : 'Phx-Pj-Dom-Builder'
}

{ #category : 'instance creation' }
DomTextNode class >> new [ 

	self error: 'use #new: instead'
]

{ #category : 'instance creation' }
DomTextNode class >> new: aString [

	^ super new
		  text: aString;
		  yourself
]

{ #category : 'accessing' }
DomTextNode >> streamHtmlOn: ws [

	ws << text
]

{ #category : 'accessing' }
DomTextNode >> text [

	^ text
]

{ #category : 'accessing' }
DomTextNode >> text: anObject [

	text := anObject
]
