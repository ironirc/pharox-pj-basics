Class {
	#name : 'PhxClientWebSocketHandler',
	#superclass : 'PjDomController',
	#traits : 'PhxPjPromiseTrait + PhxPjLoggingTrait + PhxPubSubTrait',
	#classTraits : 'PhxPjPromiseTrait classTrait + PhxPjLoggingTrait classTrait + PhxPubSubTrait classTrait',
	#instVars : [
		'webSocket',
		'continuations',
		'webSocketUrl',
		'tokenProvider',
		'client',
		'timeoutMs'
	],
	#category : 'Phx-Pj-Client-Server-client-side',
	#package : 'Phx-Pj-Client-Server',
	#tag : 'client-side'
}

{ #category : 'constants' }
PhxClientWebSocketHandler class >> defaultTimeoutMs [  

	^20000
]

{ #category : 'accessing' }
PhxClientWebSocketHandler >> client [

	^ client
]

{ #category : 'accessing' }
PhxClientWebSocketHandler >> client: anObject [

	client := anObject
]

{ #category : 'accessing' }
PhxClientWebSocketHandler >> clientId [

	^ self client ifNotNil: [ :c | c class clientId ]
]

{ #category : 'server messaging' }
PhxClientWebSocketHandler >> enqueueEnvelope: env onResponseDo: contBlock [

	| cont |
	cont := PhxEnvelopeWithContinuation
		        envelope: env
		        continuationBlock: contBlock.
	cont sentAtMsTimestamp: globalThis performance now. 
	continuations add: cont
]

{ #category : 'accessing' }
PhxClientWebSocketHandler >> handleReceivedEnvelope: rcvdEnvelope msTimestamp: msTimestamp [

	| envWithCont rc |
	envWithCont := self takeEnvelopeWithContinuationFromQueue:
		               rcvdEnvelope respToMsgId.

	rc := PhxClientWebSocketRequestContext new.
	rc receivedEnvelope: rcvdEnvelope.
	rc roundTripInMs:
		msTimestamp - envWithCont sentAtMsTimestamp.
	rc wsHandler: self.
	envWithCont ifNotNil: [
		rc sentEnvelope: envWithCont envelope.
		"a prior sent envelope, being answered"
		envWithCont executeFor: rc ].
	"moreover, give the message a chance to execute something (special cases)"
	rcvdEnvelope msg executeInResponseContext: rc
]

{ #category : 'initialize-release' }
PhxClientWebSocketHandler >> initialize [

	super initialize.
	continuations := OrderedCollection new.
	self initializePubSubTrait
]

{ #category : 'server messaging' }
PhxClientWebSocketHandler >> onWebSocketClose: event [

	self logSelfAndAll: { 
			'onWebSocketClose:'.
			event }.
	"self shouldAutoReconnect ifTrue: ["
	globalThis 
		setTimeout: [ 
			self logSelfAndAll: { 
					'onWebSocketClose:'.
					event.
					'Attempt to re-open' }.
			self setupConnectionWithServer ]
		ms: 2000 "]"
]

{ #category : 'server messaging' }
PhxClientWebSocketHandler >> onWebSocketError: event [
	self
		logSelfAndAll:
			{'onWebSocketError:'.
			event}
]

{ #category : 'accessing' }
PhxClientWebSocketHandler >> onWebSocketMessage: event [

	| rcvdEnvelope msTimestamp |
	"self logAll: {
			'receive'.
			event data }."
	msTimestamp := globalThis performance now. 
	rcvdEnvelope := PhxJsonReader readFromString: event data.
	self logAll: {
			'received env:'.
			rcvdEnvelope msg }.
	self handleReceivedEnvelope: rcvdEnvelope msTimestamp: msTimestamp
]

{ #category : 'server messaging' }
PhxClientWebSocketHandler >> onWebSocketOpen: event [
	self
		logSelfAndAll:
			{'onWebSocketOpen:'.
			event.
			'Websocket has been opened.'}.
]

{ #category : 'server messaging' }
PhxClientWebSocketHandler >> promiseAccessToken [

	^ self tokenProvider
		  ifNil: [ self promiseResolve: nil ]
		  ifNotNil: [ :tp | tp promiseAccessToken ]
]

{ #category : 'server messaging' }
PhxClientWebSocketHandler >> promiseResponseFor: aMessage [

	^ self
		  promiseResponseFor: aMessage
		  timeout: (self timeoutMs ifNil: [ self class defaultTimeoutMs ])
]

{ #category : 'server messaging' }
PhxClientWebSocketHandler >> promiseResponseFor: aMessage timeout: ms [

	^ self promiseAccessToken then: [ :aJwt |
		  self
			  promise: [ :resolve :reject |
				  | env |
				  env := aMessage wrapInEnvelope.
				  env senderId: self clientId.
				  env jwt: aJwt.
				  self
					  enqueueEnvelope: env
					  onResponseDo: [ :respCtx | resolve value: respCtx ].
				  self logAll: {
						  'sent'.
						  env msg }.
				  self sendStringThroughWebsocket: env asPhxJsonString ]
			  withinMs: ms ]
]

{ #category : 'server messaging' }
PhxClientWebSocketHandler >> sendMessageToServer: aMessage inResponseToEnvelope: incomingEnvelope [
	"incomingEnvelope seldom needed. It would be the envelope of a request that came from server"

	self promiseAccessToken then: [ :aJwt |
		| env |
		env := aMessage wrapInEnvelope.
		env senderId: self clientId.
		env jwt: aJwt.
		incomingEnvelope ifNotNil: [
			env respToMsgId: incomingEnvelope msg id ].
		self logAll: {
				'sent'.
				env msg }.
		self sendStringThroughWebsocket: env asPhxJsonString ]
]

{ #category : 'server messaging' }
PhxClientWebSocketHandler >> sendStringThroughWebsocket: aString [

	webSocket readyState == globalThis WebSocket OPEN ifFalse: [
		self logSelfAndAll: {
				'sendStringThroughWebsocket:'.
				aString.
				'SOCKET NOT OPEN' }.
		^ self ].
	"	self logSelfAndAll: { 
			'sendStringThroughWebsocket:'.
			aString }."
"	self logAll: {
			'send'.
			aString }."
	webSocket send: aString
]

{ #category : 'server messaging' }
PhxClientWebSocketHandler >> setupConnectionWithServer [

	self emitEvent: PhxPseWebSocketConnecting new.
	webSocket := WebSocket new: self webSocketUrl.
	self logSelfAndAll: { 
			'setupConnectionWithServer'.
			webSocket }.
	webSocket at: 'onopen' put: [ :event | 
		self onWebSocketOpen: event.
		self logSelfAndAll: { 'setupConnectionWithServer'.
		'NOW OPEN' }.
		self emitEvent: (PhxPseWebSocketOpened newWith: event) ].
	webSocket at: 'onmessage' put: [ :event | 
		self onWebSocketMessage: event.
		self emitEvent: (PhxPseWebSocketMessageReceived newWith: event) ].
	webSocket at: 'onclose' put: [ :event | 
		self onWebSocketClose: event.
		self emitEvent: (PhxPseWebSocketClosed newWith: event) ].
	webSocket at: 'onerror' put: [ :event | 
		self onWebSocketError: event.
		self emitEvent: (PhxPseWebSocketErrorOccurred newWith: event) ]
]

{ #category : 'server messaging' }
PhxClientWebSocketHandler >> takeEnvelopeWithContinuationFromQueue: msgId [

	| envWithCont |
	envWithCont := continuations
		               detect: [ :each | each envelope msg id = msgId ]
		               ifNone: [ nil ].
	"envWithCont ifNotNil: [
		console log: 'removed envWithCont ' with: envWithCont.
		continuations remove: envWithCont ]."
	^ envWithCont
]

{ #category : 'accessing' }
PhxClientWebSocketHandler >> timeoutMs [

	^ timeoutMs
]

{ #category : 'accessing' }
PhxClientWebSocketHandler >> timeoutMs: anObject [

	timeoutMs := anObject
]

{ #category : 'accessing' }
PhxClientWebSocketHandler >> tokenProvider [

	^ tokenProvider
]

{ #category : 'accessing' }
PhxClientWebSocketHandler >> tokenProvider: anObject [

	tokenProvider := anObject
]

{ #category : 'server messaging' }
PhxClientWebSocketHandler >> webSocketUrl [

	^ webSocketUrl
]

{ #category : 'accessing' }
PhxClientWebSocketHandler >> webSocketUrl: anObject [

	webSocketUrl := anObject
]
