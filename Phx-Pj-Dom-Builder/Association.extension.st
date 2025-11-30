Extension { #name : 'Association' }

{ #category : '*Phx-Pj-Dom-Builder' }
Association >> phxBuildComponentPropertiesOn: aBuilder [
	| aBlockOrObject |
	aBlockOrObject := self value.
"	aBlockOrObject isBlock
		ifTrue: [ aBuilder _bindValueWithChangedEvent: aBlockOrObject event: self key.
			^ self ]."
	aBuilder __privateAtProperty: self key put: aBlockOrObject
]

{ #category : '*Phx-Pj-Dom-Builder' }
Association >> phxBuildComponentSlotsOn: aBuilder [
	aBuilder __privateAtSlot: self key put: self value
]

{ #category : '*Phx-Pj-Dom-Builder' }
Association >> phxBuildDomNodeAttributesOn: aBuilder [
	aBuilder __privateAtAttribute: self key put: self value
]

{ #category : '*Phx-Pj-Dom-Builder' }
Association >> phxBuildDomNodeClassesOn: aBuilder [
	aBuilder _class: self key if: self value
]

{ #category : '*Phx-Pj-Dom-Builder' }
Association >> phxBuildDomNodeStylesOn: aBuilder [
	aBuilder _privateAtStyle: self key put: self value
]
