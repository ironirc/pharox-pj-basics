"
Overridden some methods to support exporting without appClass, in the incremental exporter.
This should enable exporting a pj-core.js and subsequently add-on modules.
Stil under development.

To-Do: 
After exporting pj-core.js, snapshot(copy) the tranpiler state, to enable rollback to the point from where add-modules can be exported. This would be the speed-up the dev cycle. (to save the 1 second needed to transpile the core)
"
Class {
	#name : 'PhxFileExporter',
	#superclass : 'PjFileExporter',
	#category : 'Phx-Pj-Client-Server-server-side',
	#package : 'Phx-Pj-Client-Server',
	#tag : 'server-side'
}

{ #category : 'accessing - description' }
PhxFileExporter >> launchBlock [

	^ launchBlock ifNil: [ 
		  self appClass ifNotNil: [ self appClass appLaunchBlock ] ]
]

{ #category : 'accessing - description' }
PhxFileExporter >> setupCode [

	^ self appClass ifNil: [ PjDOMApplication setupCode ] ifNotNil: [ self appClass setupCode ]
]

{ #category : 'accessing - description' }
PhxFileExporter >> writeGlobalsPolyfills: pools [

	pools do: [ :pool | 
		self appClass ifNotNil: [ 
			self appClass
				polyfill: pool
				withTranspiler: self transpiler
				unlessIn: globalsPools ] ]
]

{ #category : 'accessing - description' }
PhxFileExporter >> writeJsCoreAndBootstrap [

	self setupCode ifNotNilOrEmpty: [ 
		self
			nextPutAll: self setupCode;
			cr ].
	self writeCore.
	self transpiler
		convertAllClasses: self bootstrapClasses
		writeDnu: false
]

{ #category : 'accessing - description' }
PhxFileExporter >> writeLaunchCode [

	self launchBlock ifNotNil: [self transpiler convertAndWriteClosedBlock: self launchBlock]
]
