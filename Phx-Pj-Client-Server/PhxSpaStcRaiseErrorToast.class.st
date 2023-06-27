Class {
	#name : #PhxSpaStcRaiseErrorToast,
	#superclass : #PhxSpaServerToClientMessage,
	#instVars : [
		'message'
	],
	#category : #'Phx-Pj-Client-Server-shared'
}

{ #category : #private }
PhxSpaStcRaiseErrorToast >> executeInResponseContext: rc [

	rc client toastManager raiseToastWithErrorMessage: self message
]

{ #category : #accessing }
PhxSpaStcRaiseErrorToast >> message [
	^ message
]

{ #category : #accessing }
PhxSpaStcRaiseErrorToast >> message: anObject [
	message := anObject
]
