Class {
	#name : 'PhxPjIncrementalExporterWithCache',
	#superclass : 'Object',
	#instVars : [
		'exporter',
		'cache',
		'applicationClass'
	],
	#category : 'Phx-Pj-Client-Server-server-side',
	#package : 'Phx-Pj-Client-Server',
	#tag : 'server-side'
}

{ #category : 'accessing' }
PhxPjIncrementalExporterWithCache >> applicationClass [

	^ applicationClass
]

{ #category : 'accessing' }
PhxPjIncrementalExporterWithCache >> applicationClass: anObject [

	applicationClass := anObject
]

{ #category : 'private' }
PhxPjIncrementalExporterWithCache >> cache [

	^ cache ifNil: [ cache := Dictionary new ]
]

{ #category : 'private' }
PhxPjIncrementalExporterWithCache >> exporter [

	exporter ifNil: [ exporter := self newExporter ].
	^ exporter
]

{ #category : 'private' }
PhxPjIncrementalExporterWithCache >> exporter: anExporter [

	exporter := anExporter
]

{ #category : 'public' }
PhxPjIncrementalExporterWithCache >> initialScript [

	^ self jsAtKey: #initialScript ifAbsentPut: [ 
		  String streamContents: [ :ws | "  ws << "
			  self exporter writeJsCodeOn: ws.
			  self applicationClass ifNotNil: [ :ac | 
				  ws cr.
				  ws << (self jsAtKey: #boot classes: { ac }).
				  ws cr.
				  ws << self applicationClass name << '.pj_boot();' ] ] ]
]

{ #category : 'public' }
PhxPjIncrementalExporterWithCache >> jsAtKey: aKey classes: classes [

	^ self jsAtKey: aKey ifAbsentPut: [ self jsForClasses: classes ]
]

{ #category : 'private' }
PhxPjIncrementalExporterWithCache >> jsAtKey: aKey ifAbsentPut: aBlock [

	aKey ifNil: [ self error: 'key can''t be nil' ].
	^ self cache
		  at: aKey
		  ifAbsentPut: aBlock
]

{ #category : 'public' }
PhxPjIncrementalExporterWithCache >> jsAtKey: aKey objectOrBlock: object [

	^ aKey ifNil: [ self jsForObjectOrBlock: object ] ifNotNil: [ 
		  self cache
			  at: aKey
			  ifAbsentPut: [ self jsForObjectOrBlock: object ] ]
]

{ #category : 'private' }
PhxPjIncrementalExporterWithCache >> jsForClasses: classes [

	^ self exporter convertAllClassesToJs: classes
]

{ #category : 'public' }
PhxPjIncrementalExporterWithCache >> jsForObjectOrBlock: object [

	^ self exporter convertToJs: object
]

{ #category : 'private' }
PhxPjIncrementalExporterWithCache >> newExporter [

	^ self applicationClass
		  ifNil: [ PhxFileExporter new ]
		  ifNotNil: [ :ac | ac exporterClass newWithAppClass: ac ]
]

{ #category : 'initialization' }
PhxPjIncrementalExporterWithCache >> reset [

	exporter := nil.
	cache := nil
]
