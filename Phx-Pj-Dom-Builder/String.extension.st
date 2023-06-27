Extension { #name : #String }

{ #category : #'*Phx-Pj-Dom-Builder' }
String >> phxBuildDomNodeClassesOn: aBuilder [
	aBuilder _addClassesInString: self
]

{ #category : #'*Phx-Pj-Dom-Builder' }
String >> phxBuildDomNodeOn: aBuilder [
	aBuilder << self
]

{ #category : #'*Phx-Pj-Dom-Builder' }
String >> phxBuildDomNodeStylesOn: aBuilder [
	self styleAssociationsDo: [ :prop :val | aBuilder _privateAtStyle: prop put: val ]
]
