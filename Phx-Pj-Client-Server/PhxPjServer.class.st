Class {
	#name : #PhxPjServer,
	#superclass : #Object,
	#category : #'Phx-Pj-Client-Server'
}

{ #category : #initialization }
PhxPjServer class >> registerApplication: app [

	| d |
	d := ZnServer default delegate.
	d map: app httpPath to: [ :request :response |
		response entity: (ZnEntity html: app htmlPageWithInitialScript) ]. ", '/index.html'"
	d map: app httpPath , '.js' to: [ :request :response |
		response entity: (ZnEntity text: app initialScript) ].
	d map: app webSocketPath to: (ZnWebSocketDelegate
			 map: app webSocketPath
			 to: (app newServerWebSocketHandlerForConfigDict: nil))
]

{ #category : #initialization }
PhxPjServer class >> registerApplication: appClass withConfigDict: dict [

	| deleg httpPath |
	deleg := ZnServer default delegate.
	httpPath := '/' , (dict getPath: #( httpPath )).
	deleg map: httpPath to: [ :request :response |
		response entity: (ZnEntity html: appClass htmlPageWithInitialScript) ].
	deleg map: httpPath , '.js' to: [ :request :response |
		response entity: (ZnEntity text: appClass initialScript) ].
	deleg map: httpPath , '-ws' to: (ZnWebSocketDelegate
			 map: (httpPath , '-ws')
			 to: (appClass newServerWebSocketHandlerForConfigDict: dict)).
	deleg map: httpPath , '.config' to: [ :request :response |
		response entity: (ZnEntity text: dict asJsonString) ]
]

{ #category : #initialization }
PhxPjServer class >> startDefaultZnServer [

	| delegate |
	delegate := ZnDispatcherDelegate new.
	(ZnServer startDefaultOn: 8888) delegate: delegate.
	ZnServer default reader: [ :stream | ZnRequest readBinaryFrom: stream ].
	"ZnServer default logToTranscript"
]
