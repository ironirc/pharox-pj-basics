Trait {
	#name : 'PhxPjRequireTrait',
	#category : 'Phx-Pj-Core-Traits',
	#package : 'Phx-Pj-Core-Traits'
}

{ #category : 'require traits' }
PhxPjRequireTrait >> require: aName [
	<javascript: 'return require(aName)'>
	
]

{ #category : 'require traits' }
PhxPjRequireTrait >> require: aModuleName get: aName [

	^ (self require: aModuleName) at: aName
]
