Class {
	#name : 'PhxPjTest_ObjectBuilder',
	#superclass : 'AgxAbstractTestCase',
	#category : 'Phx-Pj-Testing-Framework',
	#package : 'Phx-Pj-Testing-Framework'
}

{ #category : 'as yet unclassified' }
PhxPjTest_ObjectBuilder >> brol [

	{
		(#person -> {
			 (#fullName -> 'Alice Smith').
			 (#shoeSize -> 38).
			 (#isFunny -> true).
			 (#dateOfBirth -> '1990-05-15').

			 (#prefs -> {
				  { (#shirtColor -> 'blue') }.
				  { (#favouriteFood -> 'pizza') } }).
			 (#hobbies -> { 'reading'. 'painting' }) }).
		(#onNewsMessageDo -> [ :message | 'Sending Alice a news message: ' , message ]) } asJsObject
]

{ #category : 'tests' }
PhxPjTest_ObjectBuilder >> prettyPrintObject: obj [

	console log: (JSON stringify: obj with: nil with: 2)
]

{ #category : 'tests low level related' }
PhxPjTest_ObjectBuilder >> testArrayLiteralVsNew [
	"conclusions: In js:
	-add also works on Array. 
	"

	| a1 a2 |
	a1 := { 1. 'hello' }.
	self assert: a1 class equals: Array.
	a1 add: 'world'.
	self assert: a1 size equals: 3.

	a2 := Array with: 1 with: 'hello'.
	self assert: a2 class equals: Array.
	a2 add: 'world'.
	self assert: a2 size equals: 3
]

{ #category : 'tests low level related' }
PhxPjTest_ObjectBuilder >> testArrayVsOrderedCollection [
	"conclusions: In js:
	-add also works on Array. 
	-OrderedCollection is subclass from Array, with some extra methods"

	| oc ar |
	oc := OrderedCollection new.
	oc add: 1.
	oc add: 'hello'.
	self assert: oc class equals: OrderedCollection.
	oc add: 'world'.
	self assert: oc size equals: 3.
	self
		assert: (oc isKindOf: Array)
		description: 'oc should be kind of Array'.
	ar := { 1. 'hello' }.
	self assert: ar class equals: Array.
	ar add: 'world'.
	self assert: ar size equals: 3.
	self assert: oc equals: ar
]

{ #category : 'tests' }
PhxPjTest_ObjectBuilder >> testBuildCollection [

	| coll |
	coll :=  [ :x |
		        {
			        [ x temp: 10 ].
			        [ x halo: 'bright' ] } ] jsObj.
	self
		assert: (coll isKindOf: Array)
		description: 'should be kind of Array'.
	self assert: coll first temp equals: 10.
	self assert: coll second halo equals: 'bright'
]

{ #category : 'tests builder internals' }
PhxPjTest_ObjectBuilder >> testCollectionBuildResultIsClassCollection [

	| x o |
	x := PhxPjObjectBuilder new.
	o := x buildCollection: [  ].
	self assert: o class equals: OrderedCollection
]

{ #category : 'tests low level related' }
PhxPjTest_ObjectBuilder >> testCompareAsJsObjectAtEveryLevelOrOnlyOnOuterLevel [

	| result1 result2 |
	result1 := { ('filter' -> { ('must_not' -> { {
		             ('key' -> 'id').
		             ('match' -> { ('value' -> 0) } asJsObject) } asJsObject }) }
		            asJsObject) } asJsObject.
	result2 := { 'filter' -> { 'must_not' -> { {
		             'key' -> 'id'.
		             'match' -> { 'value' -> 0 } } } } } asJsObject.
	self assert: result1 asJSON equals: result2 asJSON
]

{ #category : 'tests low level related' }
PhxPjTest_ObjectBuilder >> testDistinguishStringFromArray [

	self assert: 'abc' isString description: 'should be string'.
	self
		assert: { 1. 2 } isString not
		description: 'should not be string'.
	self
		assert: { 1. 2 } isCollection
		description: 'should be collection'.
]

{ #category : 'tests builder internals' }
PhxPjTest_ObjectBuilder >> testIsKeyword [ 

	| x  |
	x := PhxPjObjectBuilder new.
	self assert: (x isKeyword: #type:) equals: true
]

{ #category : 'tests builder internals' }
PhxPjTest_ObjectBuilder >> testObjectBuildResultIsClassObject [

	| x o |
	x := PhxPjObjectBuilder new.
	o := x buildObject: [  ].
	self assert: o class equals: Object
]

{ #category : 'tests builder internals' }
PhxPjTest_ObjectBuilder >> testObjectBuildWithDNU_keyValue [

	| x o |
	x := PhxPjObjectBuilder new.
	o := x buildObject: [ x type: 'hollow' ].
	self assert: o type equals: 'hollow'
]

{ #category : 'tests builder internals' }
PhxPjTest_ObjectBuilder >> testStackEmptyAfterObjectBuild [

	| ob o |
	ob := PhxPjObjectBuilder new.
	o := ob buildObject: [ :x |  ].
	self
		assert: ob stackTopKey isNil
		description: 'stack should be empty after object build'.
	self
		assert: ob stackTopValue isNil
		description: 'stack should be empty after object build'
	"self assert: o class equals: Object"
]

{ #category : 'tests low level related' }
PhxPjTest_ObjectBuilder >> test_assocs_asJsObject [

	| assocs |
	assocs := OrderedCollection new.
	assocs add: 'key1' -> 'value1'.
	assocs add: 'key7' -> 7.
	self assert: assocs asJsObject class equals: Object
]

{ #category : 'tests' }
PhxPjTest_ObjectBuilder >> test_complex_object [

	| obj1 obj2 |
	"PharoJs native way => asJsObject"
	obj1 := { ('config' -> {
		         ('type' -> 'hollow').
		         ('callback'
		          -> [ :arg | 'CB-Result: ' , (arg / 2) asString ]).
		         ('prefs' -> {
			          { ('color' -> 'blue') }.
			          { ('size' -> 'xl') } }).
		         ('sizes' -> { 1. 2. 3 }) }) } asJsObject.
	"PjObjectBuilder"
	obj2 := [ :x |
	        x config: [
		        x
			        type: 'hollow';
			        callback:
				        [ :arg | 'CB-Result: ' , (arg / 2) asString ] jsFunc;
			        prefs: {
					        [ x color: 'blue' ].
					        [ x size: 'xl' ] };
			        sizes: (Array with: 1 with: 2 with: 3) ] ] jsObj.
	"compare and test"
	self assert: (JSON stringify: obj1) equals: (JSON stringify: obj2).
	self
		assert: ((obj1 config at: 'callback') value: 42)
		equals: 'CB-Result: 21'.
	self
		assert: ((obj1 config at: 'callback') value: 42)
		equals: ((obj2 config at: 'callback') value: 42)
]

{ #category : 'tests' }
PhxPjTest_ObjectBuilder >> test_complex_object2 [

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
	"PjObjectBuilder"
	obj2 := [ :x |
	        x
		        person: [
			        x
				        fullName: 'Alice Smith';
				        shoeSize: 38;
				        isFunny: true;
				        dateOfBirth: '1990-05-15';
				        prefs: {
						        [ x shirtColor: 'blue' ].
						        [ x favouriteFood: 'pizza' ] };
				        hobbies: { 'reading'. 'painting' } ];
		        onNewsMessageDo: [ :message | 'Sending Alice a news message: ' , message ] jsFunc ] jsObj.
	"self prettyPrintObject: obj2. "
	"compare and test"
	self assert: (JSON stringify: obj1) equals: (JSON stringify: obj2).
	msg := 'War is over.'.
	self assert: ((obj1 at: 'onNewsMessageDo') value: msg) equals: 'Sending Alice a news message: ' , msg.
	self assert: ((obj1 at: 'onNewsMessageDo') value: msg) equals: ((obj2 at: 'onNewsMessageDo') value: msg)
]

{ #category : 'as yet unclassified' }
PhxPjTest_ObjectBuilder >> test_complex_object_without_builder_with_plain_object [

	| obj1 obj2 |
	"PharoJs native way => asJsObject"
	obj1 := { ('config' -> {
		         ('type' -> 'hollow').
		         ('callback' -> [ :arg | 'CB-Result: ' , (arg / 2) asString ]).
		         ('prefs' -> {
			          { ('color' -> 'blue') }.
			          { ('size' -> 'xl') } }).
		         ('sizes' -> { 1. 2. 3 }) }) } asJsObject.
	obj2 := Object new at: 'config' put: (Object new
			 at: 'type' put: 'hollow';
			 at: 'callback' put: [ :arg | 'CB-Result: ' , (arg / 2) asString ];
			 at: 'prefs' put: {
					 (Object new at: 'color' put: 'blue').
					 (Object new at: 'size' put: 'xl') };
			 at: 'sizes' put: { 1. 2. 3 }).

	"compare and test"
	self assert: (JSON stringify: obj1) equals: (JSON stringify: obj2).
	self assert: ((obj1 config at: 'callback') value: 42) equals: 'CB-Result: 21'.
	self assert: ((obj1 config at: 'callback') value: 42) equals: ((obj2 config at: 'callback') value: 42)
]

{ #category : 'tests low level related' }
PhxPjTest_ObjectBuilder >> test_createObjectWithAtPut [

	| o |
	self assert: Object new class equals: Object.
	o := Object new
		     at: 'id' put: 7;
		     yourself.
	self assert: o id equals: 7
]

{ #category : 'tests' }
PhxPjTest_ObjectBuilder >> test_example_QDrantFilter [

	| intendedResult result |
	intendedResult := { ('filter' -> { ('must_not' -> {
		                    {
			                    ('key' -> 'id').
			                    ('match' -> { ('value' -> 123) }) }.
		                    {
			                    ('key' -> 'size').
			                    ('match' -> { ('value' -> 'xl') }) } }) }) }
		                  asJsObject.
	result := [ :x |
	          x filter: [
		          x must_not: {
				          [
				          x
					          key: 'id';
					          match: [ x value: 123 ] ].
				          [
				          x
					          key: 'size';
					          match: [ x value: 'xl' ] ] } ] ] jsObj.
	self assert: result asJSON equals: intendedResult asJSON
]

{ #category : 'tests builder internals' }
PhxPjTest_ObjectBuilder >> test_markAsFunction [

	| block obj |
	block := [ :arg | arg * 2 ] jsFunc.
	self assert: block isBlock description: 'should be a block'.
	self
		assert: block isMarkedAsFunction
		description: 'should be a marked as function'.
	obj := [ :x | x func: [ :arg | arg * 2 ] jsFunc ] jsObj.
	self assert: ((obj at: 'func') value: 7) equals: 14
]

{ #category : 'as yet unclassified' }
PhxPjTest_ObjectBuilder >> test_unintended_pickup_of_collection_do [

	| obj coll |
	coll := { 'a'. 'b' }.
	"PROBLEMATIC => result of `coll do:` is the original collection. 
	This result (the collection) gets through the builder, instead of the outer object.
	To force it to work, in the end nil needs to be returned."
	obj := [ :x |
	       coll do: [ :each |
		       x at: each put: each ].
	       nil ] jsObj.
	self assert: (obj at: 'a') equals: 'a'
]
