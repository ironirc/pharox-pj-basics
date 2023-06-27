Extension { #name : #BlockClosure }

{ #category : #'*Phx-Pj-Dom-Builder' }
BlockClosure >> phxBuildDomNodeOn: aBuilder [
	self cull: aBuilder currentElement cull: aBuilder
]
