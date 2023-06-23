Class {
	#name : #BaselineOfPharoXBasics,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoXBasics
}

{ #category : #baselines }
BaselineOfPharoXBasics >> baseline: spec [
	<baseline>

	self compatibility: spec.
		
	spec for: #'common' do: [
		spec postLoadDoIt: #'postload:package:'.
		self 
			prerequisites: spec;		
			packages: spec;
			groups: spec	
	]
]

{ #category : #'private - accessing' }
BaselineOfPharoXBasics >> compatibility: spec [

	"Define a 'Compatibility' group that can be used as a dependency later to overcome differences in Pharo releases"

	
]

{ #category : #'private - accessing' }
BaselineOfPharoXBasics >> groups: spec [

]

{ #category : #'private - accessing' }
BaselineOfPharoXBasics >> packages: spec [

	spec package: 'Phx-Pj-Core-Traits' with: [  ]
]

{ #category : #baselines }
BaselineOfPharoXBasics >> postload: aLoader package: aPackageSpec [
	
]

{ #category : #'private - accessing' }
BaselineOfPharoXBasics >> prerequisites: spec [
	spec baseline: 'PharoJS' with: [ spec repository: 'github://PharoJS/PharoJS' ].

]
