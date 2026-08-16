Class {
	#name : 'PhxPseWebSocketEvent',
	#superclass : 'PhxPubSubEvent',
	#instVars : [
		'payload'
	],
	#category : 'Phx-Pj-Client-Server-client-side',
	#package : 'Phx-Pj-Client-Server',
	#tag : 'client-side'
}

{ #category : 'instance creation' }
PhxPseWebSocketEvent class >> newWith: aPayload [

	^ self new
		  payload: aPayload;
		  yourself
]

{ #category : 'accessing' }
PhxPseWebSocketEvent >> payload [

	^ payload
]

{ #category : 'accessing' }
PhxPseWebSocketEvent >> payload: anObject [

	payload := anObject
]
