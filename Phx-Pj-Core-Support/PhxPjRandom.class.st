Class {
	#name : #PhxPjRandom,
	#superclass : #PjDomController,
	#category : #'Phx-Pj-Core-Support'
}

{ #category : #testing }
PhxPjRandom class >> randomBetweenZeroAnd: aNumber [

	^ (Math floor: Math random * aNumber) + 1
]

{ #category : #testing }
PhxPjRandom class >> randomStringFromCharPool: charPool size: size [

	| poolSize |
	poolSize := charPool size.
	^ String streamContents: [ :ws | 
		  size timesRepeat: [ 
			  | rndIdx |
			  rndIdx := (self randomBetweenZeroAnd: poolSize) .
			  ws << (charPool at: rndIdx) ] ]
]

{ #category : #testing }
PhxPjRandom class >> randomStringSize10 [ 
	^self randomStringFromCharPool: 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789' size: 10
]
