Class {
	#name : 'PhxEnvelope',
	#superclass : 'Object',
	#instVars : [
		'senderId',
		'time',
		'msg',
		'respToMsgId',
		'jwt'
	],
	#category : 'Phx-Pj-Client-Server-shared',
	#package : 'Phx-Pj-Client-Server',
	#tag : 'shared'
}

{ #category : 'accessing' }
PhxEnvelope class >> neoJsonMapping: mapper [
	mapper
		for: self
		do: [ :mapping | 
			mapping mapAllInstVars.
			(mapping mapInstVar: #time to: #time) valueSchema: DateAndTime ].
		mapper
		for: DateAndTime
		customDo: [ :mapping | 
			mapping decoder: [ :string | DateAndTime fromString: string ].
			mapping encoder: [ :obj |	obj asString ] ]
		
 
]

{ #category : 'initialization' }
PhxEnvelope >> initialize [
	super initialize.
	senderId := 'not initialized'.
	time := DateAndTime now
]

{ #category : 'json' }
PhxEnvelope >> jsonWriteOn: s [
	<pharoJsSkip>
	| jso |
	jso := self asJsObject.
	jso jsonWriteOn: s
]

{ #category : 'accessing' }
PhxEnvelope >> jwt [
	^ jwt
]

{ #category : 'accessing' }
PhxEnvelope >> jwt: anObject [
	jwt := anObject
]

{ #category : 'accessing' }
PhxEnvelope >> msg [
	^ msg
]

{ #category : 'accessing' }
PhxEnvelope >> msg: anObject [
	msg := anObject.
	"msgType := anObject class name."
]

{ #category : 'accessing' }
PhxEnvelope >> respToMsgId [
	^ respToMsgId
]

{ #category : 'accessing' }
PhxEnvelope >> respToMsgId: anObject [
	respToMsgId := anObject
]

{ #category : 'accessing' }
PhxEnvelope >> senderId [
	^ senderId
]

{ #category : 'accessing' }
PhxEnvelope >> senderId: anObject [
	senderId := anObject
]

{ #category : 'accessing' }
PhxEnvelope >> time [
	^ time
]

{ #category : 'accessing' }
PhxEnvelope >> time: anObject [
	time := anObject
]
