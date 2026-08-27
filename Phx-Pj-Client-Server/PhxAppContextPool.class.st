Class {
	#name : 'PhxAppContextPool',
	#superclass : 'Object',
	#instVars : [
		'factoryBlock',
		'cleanupBlock',
		'timeoutMSecs',
		'available',
		'mutex',
		'semaphore'
	],
	#category : 'Phx-Pj-Client-Server-server-side',
	#package : 'Phx-Pj-Client-Server',
	#tag : 'server-side'
}

{ #category : 'instance creation' }
PhxAppContextPool class >> size: aSize factory: aFactoryBlock cleanup: aCleanupBlock timeoutMSecs: msecs [
	^ self new
		initializeSize: aSize
		factory: aFactoryBlock
		cleanup: aCleanupBlock
		timeoutMSecs: msecs;
		yourself
]

{ #category : 'initialization' }
PhxAppContextPool >> initialize [
	super initialize.
	available := OrderedCollection new.
	mutex := Mutex new.
	semaphore := Semaphore new.
	timeoutMSecs := 10000
]

{ #category : 'initialization' }
PhxAppContextPool >> initializeSize: aSize factory: aFactoryBlock cleanup: aCleanupBlock timeoutMSecs: msecs [
	factoryBlock := aFactoryBlock.
	cleanupBlock := aCleanupBlock.
	timeoutMSecs := msecs.
	aSize timesRepeat: [
		available add: factoryBlock value.
		semaphore signal ]
]

{ #category : 'public' }
PhxAppContextPool >> withContextDo: aBlock [
	| ctx slot |
	(semaphore waitTimeoutMilliseconds: timeoutMSecs) ifTrue: [
		Error signal: 'Request session pool exhausted' ].
	ctx := mutex critical: [ available removeFirst ].
	[
		aBlock value: ctx
	] ensure: [
		slot := ctx.
		[ slot := cleanupBlock cull: ctx ] on: Error do: [ :ex | slot := ctx ].
		mutex critical: [ available addLast: slot ].
		semaphore signal ]
]
