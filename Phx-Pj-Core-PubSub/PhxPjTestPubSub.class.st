Class {
	#name : #PhxPjTestPubSub,
	#superclass : #PhxPjAbstractTestCase,
	#category : #'Phx-Pj-Core-PubSub-testing-client-side'
}

{ #category : #'initialize-release' }
PhxPjTestPubSub >> setup [

	super setup
]

{ #category : #'initialize-release' }
PhxPjTestPubSub >> tearDown [

	super tearDown.


]

{ #category : #tests }
PhxPjTestPubSub >> testEmitEvent_Emit0Arg_Accept0Arg [

	| em1 result |
	em1 := PhxPjPubSubObjectForTesting new.
	em1 onEvent: PhxPseChanged do: [ result := #success ].
	em1 emitEvent: PhxPseChanged new.
	self assert: result equals: #success
]

{ #category : #tests }
PhxPjTestPubSub >> testEmitEvent_Emit0Arg_Accept1Arg [

	| em1 result |
	em1 := PhxPjPubSubObjectForTesting new.
	em1 onEvent: PhxPseChanged do: [ :arg | result := arg ].
	em1 emitEvent: PhxPseChanged new.
	self assert: result class equals: PhxPseChanged
]

{ #category : #tests }
PhxPjTestPubSub >> testEmitEvent_Emit1Arg [

	| em1 result |
	em1 := PhxPjPubSubObjectForTesting new.
	em1 onEvent: PhxPseChanged do: [ result := #success ].
	self shouldRaiseError: [
		em1 emitEvent: PhxPseChanged new with: #argThatCausesError ]
]

{ #category : #tests }
PhxPjTestPubSub >> testEmitString_Emit0Arg_Accept0Arg [

	| em1 result |
	em1 := PhxPjPubSubObjectForTesting new.
	em1 onEvent: 'hello' do: [ result := #success ].
	em1 emitEvent: 'hello'.
	self assert: result equals: #success
]

{ #category : #tests }
PhxPjTestPubSub >> testEmitString_Emit0Arg_Accept1Arg [

	| em1 result |
	em1 := PhxPjPubSubObjectForTesting new.
	em1 onEvent: 'hello' do: [:arg |  result := arg ].
	em1 emitEvent: 'hello'.
	self assert: result equals: nil
]

{ #category : #tests }
PhxPjTestPubSub >> testEmitString_Emit1Arg_Accept0Arg [

	| em1 result |
	em1 := PhxPjPubSubObjectForTesting new.
	em1 onEvent: 'hello' do: [ result := #success ].
	em1 emitEvent: 'hello' with: #arg.
	self assert: result equals: #success
]

{ #category : #tests }
PhxPjTestPubSub >> testEmitString_Emit1Arg_Accept1Arg [

	| em1 result |
	em1 := PhxPjPubSubObjectForTesting new.
	em1 onEvent: 'hello' do: [:arg |  result := arg ].
	em1 emitEvent: 'hello' with: #arg.
	self assert: result equals: #arg
]
