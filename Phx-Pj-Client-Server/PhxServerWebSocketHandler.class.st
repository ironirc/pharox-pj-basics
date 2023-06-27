Class {
	#name : #PhxServerWebSocketHandler,
	#superclass : #Object,
	#instVars : [
		'applicationClass',
		'sessionClass',
		'lock',
		'webSocketsDict',
		'context'
	],
	#category : #'Phx-Pj-Client-Server-server-side'
}

{ #category : #accessing }
PhxServerWebSocketHandler >> applicationClass [

	^ applicationClass
]

{ #category : #accessing }
PhxServerWebSocketHandler >> applicationClass: anObject [

	applicationClass := anObject
]

{ #category : #'live code update broadcasting' }
PhxServerWebSocketHandler >> boadcastMessage: msg [
	self
		broadcastEnvelopeToAllRegisteredWebsockets: msg wrapInEnvelope
]

{ #category : #private }
PhxServerWebSocketHandler >> broadcastEnvelopeToAllRegisteredWebsockets: anEnvelope [

	webSocketsDict valuesDo: [ :wsi | 
		wsi webSocket isConnected ifTrue: [ 
			[ wsi sendEnvelope: anEnvelope ]
				on: Error
				do: [ :ex | ex return ] ] ]
]

{ #category : #accessing }
PhxServerWebSocketHandler >> closeAllWebsockets [
	webSocketsDict keys copy
		do: [ :each | 
			[ self unregister: each.
			each close ]
				on: Error
				do: [ :ex | ex return ] ]
]

{ #category : #accessing }
PhxServerWebSocketHandler >> context [
	"is an PhxAppContext"

	^ context
]

{ #category : #accessing }
PhxServerWebSocketHandler >> context: anObject [
	context := anObject
]

{ #category : #private }
PhxServerWebSocketHandler >> ensuredContext [

	"is an PhxAppContext"

	(self context isNil or: [ self context isAlive not ]) ifTrue: [ 
		self context: self applicationClass newAppContext ].
	^ self context
]

{ #category : #accessing }
PhxServerWebSocketHandler >> handleMessage: rawSocketMessage forSocket: aWebSocket [

	| env webSocketSession |
	webSocketSession := self webSocketInfoFor: aWebSocket.
	webSocketSession ifNil: [ self error: 'unknown websocket' ].
	env := PhxJsonReader readFromString: rawSocketMessage.
	[webSocketSession handleIncomingEnvelope: env fromHandler: self] fork
]

{ #category : #'live code update broadcasting' }
PhxServerWebSocketHandler >> handleSystemAnnouncement: ann [

	self applicationClass
		handleSystemAnnouncement: ann
		withWebSocketMessageHandler: self
]

{ #category : #'initialize-release' }
PhxServerWebSocketHandler >> initialize [

	webSocketsDict := IdentityDictionary new.
	lock := Mutex new.

]

{ #category : #'live code update broadcasting' }
PhxServerWebSocketHandler >> isSubscribedToSystemAnnouncer [

	^ SystemAnnouncer uniqueInstance hasSubscriber: self
]

{ #category : #private }
PhxServerWebSocketHandler >> register: clientWebSocket [

	Transcript
		cr;
		show: 'Registering websocket'.
	lock critical: [
		| newWsi |
		newWsi := self sessionClass new.
		newWsi webSocket: clientWebSocket.
		webSocketsDict at: clientWebSocket put: newWsi ]
]

{ #category : #'ad hoc dev' }
PhxServerWebSocketHandler >> reportWebSocketsToTranscript [
	Transcript cr.
	webSocketsDict values
		do: [ :inf | 
			inf
				ifNil: [ Transcript show: 'Websocket without info?' ]
				ifNotNil: [ inf reportToTranscript ] ]
		separatedBy: [ Transcript cr ]
]

{ #category : #accessing }
PhxServerWebSocketHandler >> sendEnvelope: anEnvelope viaSocket: aWebSocket [
	anEnvelope senderId: self id.
	aWebSocket sendMessage: anEnvelope asPhxJsonString
]

{ #category : #accessing }
PhxServerWebSocketHandler >> sessionClass [

	^ sessionClass ifNil: [ PhxServerWebSocketSession ]
]

{ #category : #accessing }
PhxServerWebSocketHandler >> sessionClass: anObject [

	sessionClass := anObject
]

{ #category : #'live code update broadcasting' }
PhxServerWebSocketHandler >> subscribeToSystemAnnouncer [
	<script>
	self unsubscribeFromSystemAnnouncer.
	SystemAnnouncer uniqueInstance weak
		when:
			ClassAdded , ClassModifiedClassDefinition , ClassRemoved
				, ClassRenamed , MethodAdded , MethodModified , MethodRemoved
		send: #handleSystemAnnouncement:
		to: self 
]

{ #category : #private }
PhxServerWebSocketHandler >> unregister: clientWebSocket [
	lock
		critical: [ webSocketsDict removeKey: clientWebSocket ifAbsent: [  ].
			Transcript
				cr;
				show: 'Un-Registered websocket' ]
]

{ #category : #'live code update broadcasting' }
PhxServerWebSocketHandler >> unsubscribeFromSystemAnnouncer [
	<script>
	SystemAnnouncer uniqueInstance unsubscribe: self.

]

{ #category : #accessing }
PhxServerWebSocketHandler >> value: aWebSocket [
	[ self register: aWebSocket.
	aWebSocket
		runWith:
			[ :aMessage | self handleMessage: aMessage forSocket: aWebSocket ] ]
		on: Error
		do: [ self unregister: aWebSocket ]
]

{ #category : #accessing }
PhxServerWebSocketHandler >> webSocketInfoFor: aWebSocket [
	^ webSocketsDict at: aWebSocket ifAbsent: [ nil ]
]

{ #category : #private }
PhxServerWebSocketHandler >> webSocketSessionClass [

	^ PhxServerWebSocketSession
]
