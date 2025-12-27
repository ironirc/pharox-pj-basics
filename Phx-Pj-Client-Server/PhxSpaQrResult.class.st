Class {
	#name : 'PhxSpaQrResult',
	#superclass : 'PhxSpaServerToClientMessage',
	#instVars : [
		'result',
		'rawQueryTime',
		'page',
		'pageSize',
		'totalRows'
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
PhxSpaQrResult >> page [

	^ page
]

{ #category : 'accessing' }
PhxSpaQrResult >> page: anObject [

	page := anObject
]

{ #category : 'accessing' }
PhxSpaQrResult >> pageSize [

	^ pageSize
]

{ #category : 'accessing' }
PhxSpaQrResult >> pageSize: anObject [

	pageSize := anObject
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

{ #category : 'accessing' }
PhxSpaQrResult >> totalRows [

	^ totalRows
]

{ #category : 'accessing' }
PhxSpaQrResult >> totalRows: anObject [

	totalRows := anObject
]
