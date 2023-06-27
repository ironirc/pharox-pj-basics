Class {
	#name : #PhxPjServer,
	#superclass : #Object,
	#category : #'Phx-Pj-Client-Server'
}

{ #category : #initialization }
PhxPjServer class >> registerApplication: app [

	| d |
	d := ZnServer default delegate.
	d map: app httpPath ", '/index.html'" to: [ :request :response | 
		response entity: (ZnEntity html: app htmlPageWithInitialScript) ].
	d map: app httpPath , '.js' to: [ :request :response | 
		response entity: (ZnEntity text: app initialScript) ].
	d map: app webSocketPath to: (ZnWebSocketDelegate
			 map: app webSocketPath
			 to: app newServerWebSocketHandler)
]

{ #category : #initialization }
PhxPjServer class >> startDefaultZnServer [

	| delegate |
	delegate := ZnDispatcherDelegate new.
	(ZnServer startDefaultOn: 8888) delegate: delegate.
	ZnServer default reader: [ :stream | ZnRequest readBinaryFrom: stream ].
	"ZnServer default logToTranscript"
]
