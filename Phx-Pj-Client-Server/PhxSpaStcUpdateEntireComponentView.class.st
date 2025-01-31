Class {
	#name : 'PhxSpaStcUpdateEntireComponentView',
	#superclass : 'PhxSpaServerToClientMessage',
	#category : 'Phx-Pj-Client-Server-shared',
	#package : 'Phx-Pj-Client-Server',
	#tag : 'shared'
}

{ #category : 'private' }
PhxSpaStcUpdateEntireComponentView >> executeInResponseContext: rc [

	rc client allChildrenDo: [ :c | c isVueDirty: true ].
	rc client root forceRebuild.
"	console log: 'initializeAllCss' on: 	rc client root class."
	rc client root class initializeAllCss
]
