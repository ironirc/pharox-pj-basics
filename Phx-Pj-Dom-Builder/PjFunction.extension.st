Extension { #name : 'PjFunction' }

{ #category : '*Phx-Pj-Dom-Builder' }
PjFunction >> phxBuildDomNodeOn: aBuilder [
	self cull: aBuilder currentElement cull: aBuilder
]
