Class {
	#name : #PhxSpaAbstractMessage,
	#superclass : #PjDomController,
	#instVars : [
		'id'
	],
	#classVars : [
		'currentId'
	],
	#category : #'Phx-Pj-Client-Server-shared'
}

{ #category : #accessing }
PhxSpaAbstractMessage class >> neoJsonMapping: mapper [
	mapper
		for: self
		do: [ :mapping | 
"			mapping mapProperty: #class getter: [ :object | object className ] setter: [ :obj :val |  ]."
			mapping mapAllInstVars.
			"(mapping mapInstVar: #dob to: #dob) valueSchema: Date "].
"	mapper
		for: Date
		customDo: [ :mapping | 
			mapping decoder: [ :string | Date readFrom: string readStream pattern: 'yyyy-mm-dd' ].
			mapping encoder: [ :date | date yyyymmdd ] ]"
]

{ #category : #'instance creation' }
PhxSpaAbstractMessage class >> new [
	^ super new
		initializeId;
		yourself
]

{ #category : #accessing }
PhxSpaAbstractMessage class >> nextMessageId [
	currentId := currentId ifNil: [ 1 ] ifNotNil: [ :id | id + 1 ].
	^ currentId
]

{ #category : #private }
PhxSpaAbstractMessage >> executeInResponseContext: rc [ 
]

{ #category : #testing }
PhxSpaAbstractMessage >> expectsResponse [
	^ true
]

{ #category : #private }
PhxSpaAbstractMessage >> getAccessTokenUnverified: jwtString [
	

	<pharoJsSkip>
	| jwt claims |
	ZnBase64Encoder
		useAltAlphabetWhile: [ jwt := JsonWebSignature
				materializeCompact: jwtString
				key: nil
				checkSignature: false ].
	claims := jwt payload.
	^ ZTimestamp fromUnixTime: claims expirationTime
]

{ #category : #accessing }
PhxSpaAbstractMessage >> id [
	^ id
]

{ #category : #accessing }
PhxSpaAbstractMessage >> id: anObject [

	id := anObject
]

{ #category : #'initialize-release' }
PhxSpaAbstractMessage >> initialize [
	super initialize.

]

{ #category : #'initialize-release' }
PhxSpaAbstractMessage >> initializeId [
	id := PhxSpaAbstractMessage nextMessageId 
]

{ #category : #private }
PhxSpaAbstractMessage >> respondForRequestContext: rc [
	
]

{ #category : #public }
PhxSpaAbstractMessage >> wrapInEnvelope [
	| env |
	env := PhxEnvelope new.
	env msg: self.
	^env

]
