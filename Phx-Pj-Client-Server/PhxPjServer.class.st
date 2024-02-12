Class {
	#name : #PhxPjServer,
	#superclass : #Object,
	#category : #'Phx-Pj-Client-Server-server-side'
}

{ #category : #initialization }
PhxPjServer class >> startServerOn: port [
	"apps now register themselves"
	| newServer newDelegate |
	(ZnServer managedServers anySatisfy: [ :srv | srv port = port ])
		ifTrue: [ self error: 'conflicting port use' ].
	newDelegate := PhxPrefixMappingDelegate new.
	newServer := ZnServer startOn: port.
	newServer delegate: newDelegate.
	newServer reader: [ :stream | ZnRequest readBinaryFrom: stream ].
	^ newServer
	"ZnServer default logToTranscript"
]
