Class {
	#name : 'PhxSpaStcTetheredServerJobProgress',
	#superclass : 'PhxSpaServerToClientMessage',
	#instVars : [
		'jobId',
		'step',
		'isError',
		'subject',
		'details',
		'percent',
		'taskId',
		'parentTaskId',
		'rootJobId'
	],
	#category : 'Phx-Pj-Client-Server-shared',
	#package : 'Phx-Pj-Client-Server',
	#tag : 'shared'
}

{ #category : 'retaining' }
PhxSpaStcTetheredServerJobProgress >> correlationId [
	^ rootJobId ifNil: [ jobId ]
]

{ #category : 'accessing' }
PhxSpaStcTetheredServerJobProgress >> details [
	^ details
]

{ #category : 'accessing' }
PhxSpaStcTetheredServerJobProgress >> details: anObject [
	details := anObject
]

{ #category : 'displaying' }
PhxSpaStcTetheredServerJobProgress >> displayLine [
	| line det prefix |
	line := ''.
	(self subject notNil and: [ self subject asString notEmpty ]) ifTrue: [
		line := line , self subject asString , ' - ' ].
	det := self details.
	det ifNotNil: [
		prefix := det at: 'displayPrefix' ifAbsent: [ nil ].
		(prefix notNil and: [ prefix asString notEmpty ]) ifTrue: [
			line := line , prefix asString , ': ' ] ].
	^ line , self message asString
]

{ #category : 'private' }
PhxSpaStcTetheredServerJobProgress >> executeInResponseContext: rc [
	rc client inboundMessageStore record: self.
	(rc client mainViewComponentHolder component) ifNotNil: [ :view |
		(view respondsTo: #handleTetheredServerJobProgress:)
			ifTrue: [ view handleTetheredServerJobProgress: self ] ]
]

{ #category : 'accessing' }
PhxSpaStcTetheredServerJobProgress >> isError [
	^ isError ifNil: [ false ]
]

{ #category : 'accessing' }
PhxSpaStcTetheredServerJobProgress >> isError: anObject [
	isError := anObject
]

{ #category : 'accessing' }
PhxSpaStcTetheredServerJobProgress >> jobId [
	^ jobId
]

{ #category : 'accessing' }
PhxSpaStcTetheredServerJobProgress >> jobId: anObject [
	jobId := anObject
]

{ #category : 'accessing' }
PhxSpaStcTetheredServerJobProgress >> parentTaskId [
	^ parentTaskId
]

{ #category : 'accessing' }
PhxSpaStcTetheredServerJobProgress >> parentTaskId: anObject [
	parentTaskId := anObject
]

{ #category : 'accessing' }
PhxSpaStcTetheredServerJobProgress >> percent [
	^ percent
]

{ #category : 'accessing' }
PhxSpaStcTetheredServerJobProgress >> percent: anObject [
	percent := anObject
]

{ #category : 'accessing' }
PhxSpaStcTetheredServerJobProgress >> rootJobId [
	^ rootJobId
]

{ #category : 'accessing' }
PhxSpaStcTetheredServerJobProgress >> rootJobId: anObject [
	rootJobId := anObject
]

{ #category : 'accessing' }
PhxSpaStcTetheredServerJobProgress >> step [
	^ step
]

{ #category : 'accessing' }
PhxSpaStcTetheredServerJobProgress >> step: anObject [
	step := anObject
]

{ #category : 'accessing' }
PhxSpaStcTetheredServerJobProgress >> subject [
	^ subject
]

{ #category : 'accessing' }
PhxSpaStcTetheredServerJobProgress >> subject: anObject [
	subject := anObject
]

{ #category : 'accessing' }
PhxSpaStcTetheredServerJobProgress >> taskId [
	^ taskId
]

{ #category : 'accessing' }
PhxSpaStcTetheredServerJobProgress >> taskId: anObject [
	taskId := anObject
]
