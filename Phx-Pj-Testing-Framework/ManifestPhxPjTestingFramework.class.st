"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestPhxPjTestingFramework',
	#superclass : 'PackageManifest',
	#category : 'Phx-Pj-Testing-Framework-Manifest',
	#package : 'Phx-Pj-Testing-Framework',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestPhxPjTestingFramework class >> ruleSentNotImplementedRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGPackageDefinition #(#'Phx-Pj-Testing-Framework')) #'2025-02-21T09:55:52.176+01:00') )
]
