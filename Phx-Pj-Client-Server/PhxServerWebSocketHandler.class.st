Class {
	#name : 'PhxServerWebSocketHandler',
	#superclass : 'Object',
	#instVars : [
		'applicationClass',
		'lock',
		'webSocketsDict',
		'context'
	],
	#category : 'Phx-Pj-Client-Server-server-side',
	#package : 'Phx-Pj-Client-Server',
	#tag : 'server-side'
}

{ #category : 'accessing' }
PhxServerWebSocketHandler >> applicationClass [

	^ applicationClass
]

{ #category : 'accessing' }
PhxServerWebSocketHandler >> applicationClass: anObject [

	applicationClass := anObject
]

{ #category : 'live code update broadcasting' }
PhxServerWebSocketHandler >> boadcastMessage: msg [
	self
		broadcastEnvelopeToAllRegisteredWebsockets: msg wrapInEnvelope
]

{ #category : 'actions' }
PhxServerWebSocketHandler >> broadcastEnvelopeToAllRegisteredWebsockets: anEnvelope [

	webSocketsDict valuesDo: [ :wsi | 
		wsi webSocket isConnected ifTrue: [ 
			[ wsi sendEnvelope: anEnvelope ]
				on: Error
				do: [ :ex | ex return ] ] ]
]

{ #category : 'actions' }
PhxServerWebSocketHandler >> closeAllWebsockets [
	webSocketsDict keys copy
		do: [ :each | 
			[ self unregister: each.
			each close ]
				on: Error
				do: [ :ex | ex return ] ]
]

{ #category : 'accessing' }
PhxServerWebSocketHandler >> context [
	"is an PhxAppContext"

	^ context
]

{ #category : 'accessing' }
PhxServerWebSocketHandler >> context: anObject [
	context := anObject
]

{ #category : 'private' }
PhxServerWebSocketHandler >> ensuredContext [

	"is an PhxAppContext"
	"context has been set while registering app endpoints. Do not (re-)create them here!!!"

	"(self context isNil or: [ self context isAlive not ]) ifTrue: [ 
		self context: self applicationClass newAppContext ]."
	self context ensureSoundAndAlive. 
	^ self context
]

{ #category : 'accessing' }
PhxServerWebSocketHandler >> handleErrorsWhile: aBlock forWebSocketSession: webSocketSession incomingEnvelope: incomingEnvelope [

	aBlock
		on: Error
		do: [ :ex |
			| msg |
			"self halt. During dev, it might be convenient to halt here" 
			msg := PhxSpaStcRaiseErrorToast new. "probably better to just send an error message instead of specifically raising a toast?"
			msg message:
				'Server error while reading envelope: '
				, ex messageText doubleQuoted.
			webSocketSession sendEnvelope: msg wrapInEnvelope inResponseToIncoming: incomingEnvelope.
			self ]
]

{ #category : 'accessing' }
PhxServerWebSocketHandler >> handleMessage: rawSocketMessage forSocket: aWebSocket [

	| env webSocketSession |
	webSocketSession := self webSocketSessionForWebSocket: aWebSocket.
	webSocketSession ifNil: [ self error: 'unknown websocket' ].
	self
		handleErrorsWhile: [
		env := PhxJsonReader readFromString: rawSocketMessage ]
		forWebSocketSession: webSocketSession
		incomingEnvelope: env.
	[
	self
		handleErrorsWhile: [
		webSocketSession handleIncomingEnvelope: env fromHandler: self ]
		forWebSocketSession: webSocketSession
		incomingEnvelope: env ] fork
]

{ #category : 'live code update broadcasting' }
PhxServerWebSocketHandler >> handleSystemAnnouncement: ann [

	self applicationClass
		handleSystemAnnouncement: ann
		withWebSocketMessageHandler: self
]

{ #category : 'initialize-release' }
PhxServerWebSocketHandler >> initialize [

	webSocketsDict := IdentityDictionary new.
	lock := Mutex new.

]

{ #category : 'live code update broadcasting' }
PhxServerWebSocketHandler >> isSubscribedToSystemAnnouncer [

	^ SystemAnnouncer uniqueInstance hasSubscriber: self
]

{ #category : 'actions' }
PhxServerWebSocketHandler >> register: clientWebSocket [

	Transcript
		cr;
		show: 'Registering websocket ' , self hash printString.
	lock critical: [
		| newWsi |
		newWsi := PhxServerWebSocketSession new.
		newWsi context: self context.
		newWsi webSocket: clientWebSocket.
		webSocketsDict at: clientWebSocket put: newWsi ]
]

{ #category : 'obsolete - unused' }
PhxServerWebSocketHandler >> replaceOldWebSocket: oldWebSocket with: newWebSocket [

	webSocketsDict
		at: oldWebSocket
		ifPresent: [ :session | session webSocket: newWebSocket.
			webSocketsDict at: newWebSocket put: session. 
			
			 ].
	webSocketsDict removeKey: oldWebSocket ifAbsent: []
]

{ #category : 'ad hoc dev' }
PhxServerWebSocketHandler >> reportWebSocketsToTranscript [
	Transcript cr.
	webSocketsDict values
		do: [ :inf | 
			inf
				ifNil: [ Transcript show: 'Websocket without info?' ]
				ifNotNil: [ inf reportToTranscript ] ]
		separatedBy: [ Transcript cr ]
]

{ #category : 'accessing' }
PhxServerWebSocketHandler >> sendEnvelope: anEnvelope viaSocket: aWebSocket [
	anEnvelope senderId: self id.
	aWebSocket sendMessage: anEnvelope asPhxJsonString
]

{ #category : 'live code update broadcasting' }
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

{ #category : 'actions' }
PhxServerWebSocketHandler >> unregister: clientWebSocket [

	lock critical: [ "webSocketsDict removeKey: clientWebSocket ifAbsent: [  ].""Give clients opportunity to recover the session"
		Transcript
			cr;
			show: 'Un-Registered websocket' ]
]

{ #category : 'live code update broadcasting' }
PhxServerWebSocketHandler >> unsubscribeFromSystemAnnouncer [
	<script>
	SystemAnnouncer uniqueInstance unsubscribe: self.

]

{ #category : 'accessing' }
PhxServerWebSocketHandler >> value: aWebSocket [

	[
	self register: aWebSocket.
	aWebSocket runWith: [ :aMessage |
		self handleMessage: aMessage forSocket: aWebSocket ] ]
		on: Error
		do: [ :ex |
			('Websocket error: ' , ex messageText) crTrace.
			self unregister: aWebSocket ]
]

{ #category : 'accessing' }
PhxServerWebSocketHandler >> webSocketSessionForWebSocket: aWebSocket [

	"('WebSocketHandler ' , self hash printString) crTrace."
	^ webSocketsDict at: aWebSocket ifAbsent: [ nil ]
]
