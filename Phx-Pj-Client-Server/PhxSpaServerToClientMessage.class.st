Class {
	#name : 'PhxSpaServerToClientMessage',
	#superclass : 'PhxSpaResponse',
	#category : 'Phx-Pj-Client-Server-shared',
	#package : 'Phx-Pj-Client-Server',
	#tag : 'shared'
}

{ #category : 'retaining' }
PhxSpaServerToClientMessage >> correlationId [
	^ nil
]

{ #category : 'retaining' }
PhxSpaServerToClientMessage >> shouldRetainOnClient [
	^ self correlationId notNil
]
