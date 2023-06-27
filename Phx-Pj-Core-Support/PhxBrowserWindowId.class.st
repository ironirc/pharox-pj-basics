"
In essence, I am unique Id everytime the browser app gets run.
The Id is only kept in memory (no persistence needed)
Usefull for re-identificiation in case of a reconnect.
"
Class {
	#name : #PhxBrowserWindowId,
	#superclass : #PjDomController,
	#classInstVars : [
		'id'
	],
	#category : #'Phx-Pj-Core-Support'
}

{ #category : #accessing }
PhxBrowserWindowId class >> value [

	id ifNil: [ id := PhxPjRandom randomStringSize10 ].
	^ id
]
