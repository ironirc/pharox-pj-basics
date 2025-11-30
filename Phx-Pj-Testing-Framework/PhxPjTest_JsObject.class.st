Class {
	#name : 'PhxPjTest_JsObject',
	#superclass : 'PhxPjAbstractTestCase',
	#category : 'Phx-Pj-Testing-Framework',
	#package : 'Phx-Pj-Testing-Framework'
}

{ #category : 'tests' }
PhxPjTest_JsObject >> prettyPrintObject: obj [

	console log: (JSON stringify: obj with: nil with: 2)
]

{ #category : 'tests' }
PhxPjTest_JsObject >> test_complex_object [

	| obj1 obj2 |
	"PharoJs native way => asJsObject"
	obj1 := { ('config' -> {
		         ('type' -> 'hollow').
		         ('callback' -> [ :arg | 'CB-Result: ' , (arg / 2) asString ]).
		         ('prefs' -> {
			          { ('color' -> 'blue') }.
			          { ('size' -> 'xl') } }).
		         ('sizes' -> { 1. 2. 3 }) }) } asJsObject.
	obj2 := JsObject new config: (JsObject new
			         type: 'hollow';
			         callback: [ :arg | 'CB-Result: ' , (arg / 2) asString ];
			         prefs: {
					         (JsObject new color: 'blue').
					         (JsObject new size: 'xl') };
			         sizes: { 1. 2. 3 }).
	"compare and test"
	self assert: (JSON stringify: obj1) equals: (JSON stringify: obj2).
	self assert: ((obj1 config at: 'callback') value: 42) equals: 'CB-Result: 21'.
	self assert: ((obj1 config at: 'callback') value: 42) equals: ((obj2 config at: 'callback') value: 42)
]

{ #category : 'tests' }
PhxPjTest_JsObject >> test_complex_object2 [

	| obj1 obj2 msg |
	"PharoJs native way => asJsObject"
	obj1 := {
		        ('person' -> {
			         ('fullName' -> 'Alice Smith').
			         ('shoeSize' -> 38).
			         ('isFunny' -> true).
			         ('dateOfBirth' -> '1990-05-15').
			         ('prefs' -> {
				          { ('shirtColor' -> 'blue') }.
				          { ('favouriteFood' -> 'pizza') } }).
			         ('hobbies' -> { 'reading'. 'painting' }) }).
		        ('onNewsMessageDo' -> [ :message | 'Sending Alice a news message: ' , message ]) } asJsObject.
	"JsObject"
	obj2 := JsObject new
		        person: (JsObject new
				         fullName: 'Alice Smith';
				         shoeSize: 38;
				         isFunny: true;
				         dateOfBirth: '1990-05-15';
				         prefs: {
						         (JsObject new shirtColor: 'blue').
						         (JsObject new favouriteFood: 'pizza') };
				         hobbies: { 'reading'. 'painting' });
		        onNewsMessageDo: [ :message | 'Sending Alice a news message: ' , message ].
	self prettyPrintObject: obj2. 
	"compare and test"
	self assert: (JSON stringify: obj1) equals: (JSON stringify: obj2).
	msg := 'War is over.'.
	self assert: ((obj1 at: 'onNewsMessageDo') value: msg) equals: 'Sending Alice a news message: ' , msg.
	self assert: ((obj1 at: 'onNewsMessageDo') value: msg) equals: ((obj2 at: 'onNewsMessageDo') value: msg)
]
