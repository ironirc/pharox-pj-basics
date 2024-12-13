Class {
	#name : 'PhxSpaStcRaiseErrorToast',
	#superclass : 'PhxSpaServerToClientMessage',
	#category : 'Phx-Pj-Client-Server-shared',
	#package : 'Phx-Pj-Client-Server',
	#tag : 'shared'
}

{ #category : 'private' }
PhxSpaStcRaiseErrorToast >> executeInResponseContext: rc [

	rc client toastManager raiseToastWithErrorMessage: self message
]

{ #category : 'accessing' }
PhxSpaStcRaiseErrorToast >> message [
	^ message
]

{ #category : 'accessing' }
PhxSpaStcRaiseErrorToast >> message: anObject [
	message := anObject
]
