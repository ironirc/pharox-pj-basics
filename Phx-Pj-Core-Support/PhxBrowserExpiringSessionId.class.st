Class {
	#name : 'PhxBrowserExpiringSessionId',
	#superclass : 'PjDomController',
	#category : 'Phx-Pj-Core-Support',
	#package : 'Phx-Pj-Core-Support'
}

{ #category : 'accessing' }
PhxBrowserExpiringSessionId class >> value [

	^PhxBrowserCookieManager getCookie: 'sessionId'
]

{ #category : 'accessing' }
PhxBrowserExpiringSessionId class >> value: id expireInSeconds: s [

	PhxBrowserCookieManager
		  setCookie: 'sessionId'
		  value: id
		  expiryMs: s * 1000
]
