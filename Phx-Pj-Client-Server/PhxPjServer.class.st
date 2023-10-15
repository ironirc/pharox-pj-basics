Class {
	#name : #PhxPjServer,
	#superclass : #Object,
	#category : #'Phx-Pj-Client-Server-server-side'
}

{ #category : #initialization }
PhxPjServer class >> registerApplication: appClass withConfigDict: dict [

	| port deleg httpPath |
	port := dict getPath: #(port).
	deleg := (self startServerOn: port) delegate.
	httpPath := '/' , (dict getPath: #( httpPath )).
	deleg map: httpPath to: [ :request :response |
		response entity: (ZnEntity html: appClass htmlPageWithInitialScript) ].
	deleg map: httpPath , '.js' to: [ :request :response |
		response entity: (ZnEntity text: appClass initialScript) ].
	deleg map: httpPath , '-ws' to: (ZnWebSocketDelegate
			 map: (httpPath , '-ws')
			 to: (appClass newServerWebSocketHandlerForConfigDict: dict)).
	deleg map: httpPath , '.config' to: [ :request :response |
		response entity: (ZnEntity text: (self translateDictForClient: dict) asJsonString) ]
]

{ #category : #initialization }
PhxPjServer class >> startServerOn: port [

	| newServer newDelegate |
	(ZnServer managedServers anySatisfy: [ :srv | srv port = port ])
		ifTrue: [ self error: 'conflicting port use' ].
	newDelegate := ZnDispatcherDelegate new.
	newServer := ZnServer startOn: port.
	newServer delegate: newDelegate.
	newServer reader: [ :stream | ZnRequest readBinaryFrom: stream ].
	^ newServer
	"ZnServer default logToTranscript"
]

{ #category : #initialization }
PhxPjServer class >> translateDictForClient: dict [

	| result |
	result := Dictionary new.
	result at: 'environmentTag' put: (dict getPath: #( environmentTag )).
	result at: 'httpPath' put: (dict getPath: #( httpPath )).
	result at: 'auth0Domain' put: (dict getPath: #( auth0Spa domain  )).
	result at: 'auth0ClientId' put: (dict getPath: #( auth0Spa clientId  )).
	result at: 'auth0Audience' put: (dict getPath: #( auth0Spa apiAudience  )).
	^ result
]
