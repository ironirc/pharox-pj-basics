Class {
	#name : 'PhxSpaStcRaiseMessageToast',
	#superclass : 'PhxSpaServerToClientMessage',
	#category : 'Phx-Pj-Client-Server-shared',
	#package : 'Phx-Pj-Client-Server',
	#tag : 'shared'
}

{ #category : 'private' }
PhxSpaStcRaiseMessageToast >> executeInResponseContext: rc [

	rc client toastManager raiseToastWithSuccessMessage: self message
]

{ #category : 'accessing' }
PhxSpaStcRaiseMessageToast >> message [
	^ message
]

{ #category : 'accessing' }
PhxSpaStcRaiseMessageToast >> message: anObject [
	message := anObject
]
