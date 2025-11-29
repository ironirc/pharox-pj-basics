Extension { #name : 'PjTDomController' }

{ #category : '*Phx-Pj-Dom-Builder' }
PjTDomController >> createElement: tagString namespace: aNamespace [
	^self document js_createElementNS: aNamespace with: tagString	
]
