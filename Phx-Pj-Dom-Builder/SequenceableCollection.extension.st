Extension { #name : #SequenceableCollection }

{ #category : #'*Phx-Pj-Dom-Builder' }
SequenceableCollection >> phxBuildComponentPropertiesOn: aBuilder [
	self do: [:each |  each phxBuildComponentPropertiesOn: aBuilder ]
]

{ #category : #'*Phx-Pj-Dom-Builder' }
SequenceableCollection >> phxBuildComponentSlotsOn: aBuilder [
	self do: [:each |  each phxBuildComponentSlotsOn: aBuilder ]
]

{ #category : #'*Phx-Pj-Dom-Builder' }
SequenceableCollection >> phxBuildDomNodeAttributesOn: aBuilder [
	self do: [:each |  each phxBuildDomNodeAttributesOn: aBuilder ]
]

{ #category : #'*Phx-Pj-Dom-Builder' }
SequenceableCollection >> phxBuildDomNodeClassesOn: aBuilder [
	self do: [ :each | each phxBuildDomNodeClassesOn: aBuilder ]
]

{ #category : #'*Phx-Pj-Dom-Builder' }
SequenceableCollection >> phxBuildDomNodeStylesOn: aBuilder [
	self do: [:each |  each phxBuildDomNodeStylesOn: aBuilder ] 
]
