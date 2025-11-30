Class {
	#name : 'PhxPrefixMappingDelegate',
	#superclass : 'ZnPrefixMappingDelegate',
	#category : 'Phx-Pj-Client-Server-shared',
	#package : 'Phx-Pj-Client-Server',
	#tag : 'shared'
}

{ #category : 'public' }
PhxPrefixMappingDelegate >> handleRequest: request [

	| handler relativeRequest |
	handler := self prefixDictionary
		           at: request uri firstPathSegment
		           ifAbsent: [ ^ ZnResponse notFound: request uri ].
	relativeRequest := request copy.
	relativeRequest uri removeFirstPathSegment.
	^ handler isBlock
		  ifTrue: [ "differs from superclass by also passing a response object to the block (like ZnDispatcherDelegate does)"
			  handler value: request value: (ZnResponse new
					   statusLine: ZnStatusLine ok;
					   headers: ZnHeaders defaultResponseHeaders;
					   yourself) ]
		  ifFalse: [ handler handleRequest: relativeRequest ]
]
