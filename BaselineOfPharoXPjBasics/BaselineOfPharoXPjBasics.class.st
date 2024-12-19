Class {
	#name : 'BaselineOfPharoXPjBasics',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfPharoXPjBasics',
	#package : 'BaselineOfPharoXPjBasics'
}

{ #category : 'baselines' }
BaselineOfPharoXPjBasics >> baseline: spec [
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

{ #category : 'private - accessing' }
BaselineOfPharoXPjBasics >> compatibility: spec [

	"Define a 'Compatibility' group that can be used as a dependency later to overcome differences in Pharo releases"

	
]

{ #category : 'private - accessing' }
BaselineOfPharoXPjBasics >> groups: spec [

]

{ #category : 'private - accessing' }
BaselineOfPharoXPjBasics >> packages: spec [

	spec package: 'Phx-Pj-Core' with: [  spec requires: #( 'PharoJS')  ].
	spec package: 'Phx-Pj-Core-Traits' with: [  spec requires: #( 'PharoJS' 'Phx-Pj-Core')  ].
	spec package: 'Phx-Pj-Core-Support' with: [ spec requires: #( 'PharoJS' 'Phx-Pj-Core-Traits' 'Phx-Pj-Core') ].
	spec package: 'Phx-Pj-Dom-Builder' with: [ spec requires: #( 'PharoJS')   ].
	spec package: 'Phx-Pj-Core-PubSub'  with: [ spec requires: #( 'PharoJS' ) ].
	spec package: 'Phx-Pj-Core-PubSub-Testing'  with: [ spec requires: #( 'Phx-Pj-Testing-Framework' 'Phx-Pj-Core-PubSub') ].
	spec package: 'Phx-Pj-Web-Components' with: [ spec requires: #( 'Phx-Pj-Dom-Builder' ) ].
	spec package: 'Phx-Pj-Client-Server'  with: [ spec requires: #( 'PharoJS' 'Phx-Pj-Core-PubSub' 'Phx-Pj-Core-Traits') ].
	spec package: 'Phx-Pj-Testing-Framework'  with: [ spec requires: #( 'PharoJS' 'Phx-Pj-Core-PubSub' 'Phx-Pj-Core-Traits') ].


]

{ #category : 'baselines' }
BaselineOfPharoXPjBasics >> postload: aLoader package: aPackageSpec [
	
]

{ #category : 'private - accessing' }
BaselineOfPharoXPjBasics >> prerequisites: spec [

	spec
		baseline: 'PharoJS'
		with: [ spec repository: 'github://PharoJS/PharoJS:pharo12' ].


]
