Class {
	#name : 'PhxBrowserPersistentClientId',
	#superclass : 'PjDomController',
	#category : 'Phx-Pj-Core-Support',
	#package : 'Phx-Pj-Core-Support'
}

{ #category : 'accessing' }
PhxBrowserPersistentClientId class >> value [
	(localStorage getItem: 'clientId') ifNil: [ 
		localStorage
			setItem: 'clientId'
			value: PhxPjRandom randomStringSize10 ].
	^ localStorage getItem: 'clientId'
]
