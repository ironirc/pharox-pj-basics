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

	spec package: 'Phx-Pj-Core-Traits' with: [  spec requires: #( 'PharoJS')  ].
	spec package: 'Phx-Pj-Core-Support' with: [ spec requires: #( 'PharoJS') ].
	spec package: 'Phx-Pj-Dom-Builder' with: [ spec requires: #( 'PharoJS')   ].
	spec package: 'Phx-Pj-Core-PubSub'  with: [ spec requires: #( 'PharoJS') ].
	spec package: 'Phx-Pj-Web-Components' with: [ spec requires: #( 'Phx-Pj-Dom-Builder' ) ].
	spec package: 'Phx-Pj-Web-Components-Reactive' with: [ spec requires: #( 'Phx-Pj-Web-Components'  'PharoXPjVue' ) ].
	spec package: 'Phx-Pj-Client-Server'  with: [ spec requires: #( 'PharoJS' 'Phx-Pj-Core-PubSub' 'Phx-Pj-Core-Traits') ].
	spec package: 'Phx-Pj-Testing-Framework'  with: [ spec requires: #( 'PharoJS' 'Phx-Pj-Core-PubSub' 'Phx-Pj-Core-Traits') ].


]

{ #category : #baselines }
BaselineOfPharoXBasics >> postload: aLoader package: aPackageSpec [
	
]

{ #category : #'private - accessing' }
BaselineOfPharoXBasics >> prerequisites: spec [
	spec baseline: 'PharoJS' with: [ spec repository: 'github://PharoJS/PharoJS:pharo11' ].
	spec baseline: 'PharoXPjVue' with: [ spec repository: 'github://ironirc/pharox-pj-vue:main' ].

]
