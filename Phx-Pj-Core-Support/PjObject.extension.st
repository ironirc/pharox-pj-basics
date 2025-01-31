Extension { #name : 'PjObject' }

{ #category : '*Phx-Pj-Core-Support' }
PjObject >> at: key ifAbsentPut: aBlock [
	^ (self js_hasOwnProperty: key)
		ifTrue: [ self js_at: key ]
		ifFalse: [ self at: key put: aBlock value ]
]
