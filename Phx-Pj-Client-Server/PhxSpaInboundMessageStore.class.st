Class {
	#name : 'PhxSpaInboundMessageStore',
	#superclass : 'Object',
	#instVars : [
		'messagesByCorrelationId',
		'lastCorrelationId'
	],
	#category : 'Phx-Pj-Client-Server-client-side',
	#package : 'Phx-Pj-Client-Server',
	#tag : 'client-side'
}

{ #category : 'initialize-release' }
PhxSpaInboundMessageStore >> initialize [
	super initialize.
	messagesByCorrelationId := Dictionary new
]

{ #category : 'accessing' }
PhxSpaInboundMessageStore >> lastCorrelationId [
	^ lastCorrelationId
]

{ #category : 'api' }
PhxSpaInboundMessageStore >> messagesFor: id [
	id ifNil: [ ^ OrderedCollection new ].
	^ (messagesByCorrelationId at: id ifAbsent: [ OrderedCollection new ]) copy
]

{ #category : 'api' }
PhxSpaInboundMessageStore >> record: aMessage [
	| id list |
	aMessage shouldRetainOnClient ifFalse: [ ^ self ].
	id := aMessage correlationId.
	id ifNil: [ ^ self ].
	lastCorrelationId := id.
	list := messagesByCorrelationId at: id ifAbsentPut: [ OrderedCollection new ].
	list add: aMessage
]
