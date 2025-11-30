Class {
	#name : 'PhxPjTestReplaceProtoypeFunction',
	#superclass : 'PhxPjAbstractTestCase',
	#category : 'Phx-Pj-Testing-Framework',
	#package : 'Phx-Pj-Testing-Framework'
}

{ #category : 'tests' }
PhxPjTestReplaceProtoypeFunction >> test1 [

	| obj |
	"instance"
	self assert: PhxPjTestClass1 new foo equals: 'Hello'.
	PhxPjTestClass1 prototype at: 'pj_foo' put: (PhxPjTestClass2 prototype at: 'pj_bar').
	obj := PhxPjTestClass1 new.
	obj at: 'bar' put: 'strange'.
	self assert: obj foo equals: 'strangeWorld'.
	"class"
	self assert: PhxPjTestClass1 clsFoo equals: 'clsFoo'.
	PhxPjTestClass1 prototype class at: 'pj_clsFoo' put: (PhxPjTestClass2 prototype class at: 'pj_clsBar').
	self assert: PhxPjTestClass1 clsFoo equals: 'clsBar'.
	"class var"
	self assert: PhxPjTestClass1 clsVar equals: 'var'.
	PhxPjTestClass1 at: 'var' put: 'var2'.
	self assert: PhxPjTestClass1 clsVar equals: 'var2'
]
