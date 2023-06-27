Extension { #name : #PjArray }

{ #category : #'*Phx-Pj-Dom-Builder' }
PjArray >> phxBuildComponentPropertiesOn: aBuilder [
	self do: [:each |  each phxBuildComponentPropertiesOn: aBuilder ]
]

{ #category : #'*Phx-Pj-Dom-Builder' }
PjArray >> phxBuildComponentSlotsOn: aBuilder [
	self do: [:each |  each phxBuildComponentSlotsOn: aBuilder ]
]

{ #category : #'*Phx-Pj-Dom-Builder' }
PjArray >> phxBuildDomNodeAttributesOn: aBuilder [
	self do: [:each |  each phxBuildDomNodeAttributesOn: aBuilder ]
]

{ #category : #'*Phx-Pj-Dom-Builder' }
PjArray >> phxBuildDomNodeClassesOn: aBuilder [
	self do: [ :each | each phxBuildDomNodeClassesOn: aBuilder ]
]

{ #category : #'*Phx-Pj-Dom-Builder' }
PjArray >> phxBuildDomNodeStylesOn: aBuilder [
	self do: [:each |  each phxBuildDomNodeStylesOn: aBuilder ] 
]
