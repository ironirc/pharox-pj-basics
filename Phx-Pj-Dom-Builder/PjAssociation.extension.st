Extension { #name : #PjAssociation }

{ #category : #'*Phx-Pj-Dom-Builder' }
PjAssociation >> phxBuildComponentPropertiesOn: aBuilder [
	| aBlockOrObject |
	aBlockOrObject := self value.
"	aBlockOrObject isBlock
		ifTrue: [ aBuilder _bindValueWithChangedEvent: aBlockOrObject event: self key.
			^ self ]."
	aBuilder __privateAtProperty: self key put: aBlockOrObject
]

{ #category : #'*Phx-Pj-Dom-Builder' }
PjAssociation >> phxBuildComponentSlotsOn: aBuilder [
	aBuilder __privateAtSlot: self key put: self value
]

{ #category : #'*Phx-Pj-Dom-Builder' }
PjAssociation >> phxBuildDomNodeAttributesOn: aBuilder [
	aBuilder __privateAtAttribute: self key put: self value
]

{ #category : #'*Phx-Pj-Dom-Builder' }
PjAssociation >> phxBuildDomNodeClassesOn: aBuilder [
	aBuilder _class: self key if: self value
]

{ #category : #'*Phx-Pj-Dom-Builder' }
PjAssociation >> phxBuildDomNodeStylesOn: aBuilder [
	aBuilder _privateAtStyle: self key put: self value
]
