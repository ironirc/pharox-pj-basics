Class {
	#name : 'PhxSpaQrResult',
	#superclass : 'PhxSpaServerToClientMessage',
	#instVars : [
		'result',
		'rawQueryTime'
	],
	#category : 'Phx-Pj-Client-Server-shared',
	#package : 'Phx-Pj-Client-Server',
	#tag : 'shared'
}

{ #category : 'initialize-release' }
PhxSpaQrResult >> initialize [
	super initialize. 
	isSuccess := true
]

{ #category : 'accessing' }
PhxSpaQrResult >> rawQueryTime [
	^ rawQueryTime
]

{ #category : 'accessing' }
PhxSpaQrResult >> rawQueryTime: anObject [
	rawQueryTime := anObject
]

{ #category : 'accessing' }
PhxSpaQrResult >> result [
	^ result
]

{ #category : 'accessing' }
PhxSpaQrResult >> result: anObject [
	result := anObject
]
