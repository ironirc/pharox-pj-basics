Class {
	#name : #PhxSpaExeExecuteCode,
	#superclass : #PhxSpaServerToClientMessage,
	#instVars : [
		'code'
	],
	#category : #'Phx-Pj-Client-Server-shared'
}

{ #category : #'instance creation' }
PhxSpaExeExecuteCode class >> javascript: codeString [
	<pharoJsSkip>
	^ self new code: codeString
]

{ #category : #accessing }
PhxSpaExeExecuteCode >> code [
	^ code
]

{ #category : #accessing }
PhxSpaExeExecuteCode >> code: anObject [
	code := anObject
]

{ #category : #private }
PhxSpaExeExecuteCode >> executeInResponseContext: rc [
"	console log:  'Exe: ' , self code."
	global eval: self code
]
