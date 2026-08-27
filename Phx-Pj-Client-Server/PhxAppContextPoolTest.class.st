Class {
	#name : 'PhxAppContextPoolTest',
	#superclass : 'TestCase',
	#category : 'Phx-Pj-Client-Server-server-side-tests',
	#package : 'Phx-Pj-Client-Server',
	#tag : 'server-side-tests'
}

{ #category : 'running' }
PhxAppContextPoolTest >> newPoolSize: n timeoutMSecs: msecs [
	^ PhxAppContextPool
		size: n
		factory: [ Object new ]
		cleanup: [ :c | c ]
		timeoutMSecs: msecs
]

{ #category : 'tests' }
PhxAppContextPoolTest >> testCheckoutReturnsFactoryValue [
	| pool seen |
	pool := self newPoolSize: 1 timeoutMSecs: 1000.
	seen := nil.
	pool withContextDo: [ :ctx | seen := ctx ].
	self assert: seen notNil
]

{ #category : 'tests' }
PhxAppContextPoolTest >> testCleanupReceivesCheckedOutContext [
	| received pool ctx |
	received := nil.
	ctx := Object new.
	pool := PhxAppContextPool
		size: 1
		factory: [ ctx ]
		cleanup: [ :c | received := c. c ]
		timeoutMSecs: 1000.
	pool withContextDo: [ :c | ].
	self assert: received == ctx
]

{ #category : 'tests' }
PhxAppContextPoolTest >> testExceptionReturnsSlot [
	| pool |
	pool := self newPoolSize: 1 timeoutMSecs: 1000.
	self should: [ pool withContextDo: [ :ctx | Error signal: 'boom' ] ] raise: Error.
	pool withContextDo: [ :ctx | self assert: ctx notNil ]
]

{ #category : 'tests' }
PhxAppContextPoolTest >> testExclusiveCheckout [
	| pool inUse overlap |
	inUse := false.
	overlap := false.
	pool := self newPoolSize: 1 timeoutMSecs: 2000.
	[
		pool withContextDo: [ :ctx |
			inUse := true.
			(Delay forMilliseconds: 100) wait.
			inUse := false ]
	] fork.
	(Delay forMilliseconds: 20) wait.
	pool withContextDo: [ :ctx | overlap := inUse ].
	self deny: overlap
]

{ #category : 'tests' }
PhxAppContextPoolTest >> testTimeoutWhenPoolExhausted [
	| pool started |
	pool := self newPoolSize: 1 timeoutMSecs: 50.
	started := Semaphore new.
	[
		pool withContextDo: [ :ctx |
			started signal.
			(Delay forMilliseconds: 400) wait ]
	] fork.
	started wait.
	self should: [ pool withContextDo: [ :ctx | ] ] raise: Error
]
