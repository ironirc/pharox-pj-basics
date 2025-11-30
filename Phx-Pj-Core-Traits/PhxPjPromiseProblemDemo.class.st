Class {
	#name : 'PhxPjPromiseProblemDemo',
	#superclass : 'PjDomController',
	#traits : 'PhxPjPromiseTrait',
	#classTraits : 'PhxPjPromiseTrait classTrait',
	#category : 'Phx-Pj-Core-Traits',
	#package : 'Phx-Pj-Core-Traits'
}

{ #category : 'actions' }
PhxPjPromiseProblemDemo >> demonstrationOfUndesiredBehaviourWhenSendingBothThenAndCatchToSamePromise [
	"This demonstrates usage of #then: and #catch: leading to uninteded behaviour"
	| prom |
 
	prom := self promise: [ :res2 :rej2 |
		        PhxPjTimer
			        afterMilliseconds: 1
			        do: [ rej2 value: 'deliberate rejection' ] ].
	prom then: [ :v2 | console log: 'then prom' with: v2 ]. 
	"'prom then:' creates a promise that won't be executed, but WILL be rejected, and results in uncaught (it has no own catch handler"
	prom catch: [ :ex2 | console log: 'catch prom' with: ex2 ]
]
