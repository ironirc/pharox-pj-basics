Extension { #name : #PjString }

{ #category : #'*Phx-Pj-Dom-Builder' }
PjString >> phxBuildDomNodeAttributesOn: aBuilder [
	"just add the attribute without associated value (no '=' sign)"

	aBuilder __privateAtAttribute: self put: ''
]

{ #category : #'*Phx-Pj-Dom-Builder' }
PjString >> phxBuildDomNodeClassesOn: aBuilder [
	aBuilder _addClassesInString: self
]

{ #category : #'*Phx-Pj-Dom-Builder' }
PjString >> phxBuildDomNodeOn: aBuilder [
	aBuilder << self
]

{ #category : #'*Phx-Pj-Dom-Builder' }
PjString >> phxBuildDomNodeStylesOn: aBuilder [
	self styleAssociationsDo: [ :prop :val | aBuilder _privateAtStyle: prop put: val ]
]

{ #category : #'*Phx-Pj-Dom-Builder' }
PjString >> styleAssociationsDo: aBlock [

	(';' split: self) do: [ :decl | 
		(decl notNil and: [ decl isEmpty not ]) ifTrue: [ 
			| propAndVal prop val |
			propAndVal := ':' split: decl.
			prop := propAndVal first trim.
			val := propAndVal last trim.
			aBlock value: prop value: val ] ]
]
