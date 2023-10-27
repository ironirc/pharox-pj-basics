Class {
	#name : #PhxSpaLoader,
	#superclass : #PjDomController,
	#traits : 'PhxPjPromiseTrait',
	#classTraits : 'PhxPjPromiseTrait classTrait',
	#classVars : [
		'cache'
	],
	#category : #'Phx-Pj-Core-Support'
}

{ #category : #accessing }
PhxSpaLoader class >> cache [
	^ cache ifNil: [ cache := Dictionary new ]
]

{ #category : #'initialize - release' }
PhxSpaLoader class >> import: url [
	<javascript: 'return import(url)'>
]

{ #category : #'initialize - release' }
PhxSpaLoader class >> promiseLoadLinkedCss: aUrl [
	| p |
	(self cache at: aUrl ifAbsent: [  ])
		ifNotNil: [ :cachedPromise | ^ cachedPromise ].
	p := self
		promise: [ :resolve :reject | 
			| link |
			link := self createElement: 'link'.
			link type: 'text/css'.
			link instVarNamed: #rel put: 'stylesheet'.
			link instVarNamed: #href put: aUrl.
			link
				addEventListener: #load
				block: [ console log: aUrl.
					resolve value: aUrl ].
			link
				addEventListener: #error
				block: [ self cache removeKey: aUrl.
					reject value: aUrl ].
			document head js_appendChild: link ].
	self cache at: aUrl put: p.
	^ p
]

{ #category : #'initialize - release' }
PhxSpaLoader class >> promiseLoadScript: aUrl [
	| p |
	(self cache at: aUrl ifAbsent: [  ])
		ifNotNil: [ :cachedPromise | ^ cachedPromise ].
	p := self
		promise: [ :resolve :reject | 
			| script |
			script := self createElement: 'script'.
			script type: 'text/javascript'.
			script instVarNamed: #async put: true.
			script instVarNamed: #src put: aUrl.
			script
				addEventListener: #load
				block: [ console log: aUrl.
					resolve value: aUrl ].
			script
				addEventListener: #error
				block: [ self cache removeKey: aUrl.
					reject value: aUrl ].
			document head js_appendChild: script ].
	self cache at: aUrl put: p.
	^ p
]
