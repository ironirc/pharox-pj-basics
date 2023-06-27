Extension { #name : #PjString }

{ #category : #'*Phx-Pj-Core-PubSub' }
PjString >> asPhxPubSubSubscription [

	^ PhxPubSubSubscriptionForString new
		  string: self asJsObject;
		  yourself
]
