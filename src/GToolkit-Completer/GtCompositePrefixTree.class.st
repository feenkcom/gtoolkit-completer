Class {
	#name : #GtCompositePrefixTree,
	#superclass : #Collection,
	#instVars : [
		'trees'
	],
	#category : #'GToolkit-Completer-PrefixTree'
}

{ #category : #'instance creation' }
GtCompositePrefixTree class >> trees: aCollection [
	^ self new
		trees: aCollection;
		yourself
]

{ #category : #adding }
GtCompositePrefixTree >> add: newObject [ 
	self error: 'Cannot add new object'
]

{ #category : #enumerating }
GtCompositePrefixTree >> asyncStreamStartingWith: aString [
	^ (trees collect: [ :each | each asyncStreamStartingWith: aString ]) fold: [ :a :b | a merge: b ]
]

{ #category : #enumerating }
GtCompositePrefixTree >> asyncStreamStartingWith: aString caseSensitive: aBoolean [
	^ (trees
		collect: [ :each | each asyncStreamStartingWith: aString caseSensitive: aBoolean ])
		fold: [ :a :b | a merge: b ]
]

{ #category : #accessing }
GtCompositePrefixTree >> asyncWeightedStreamStartingWith: aString [
	^ (trees collect: [ :each | each asyncWeightedStreamStartingWith: aString ])
		fold: [ :a :b | a merge: b ]
]

{ #category : #enumerating }
GtCompositePrefixTree >> do: aBlock [
	self do: aBlock startingWith: ''
]

{ #category : #accessing }
GtCompositePrefixTree >> do: aBlock startingWith: aString [
	| seen |
	seen := Set new.
	trees
		do: [ :tree | 
			tree
				do: [ :each | 
					(seen includes: each)
						ifFalse: [ seen add: each.
							aBlock value: each ] ]
				startingWith: aString ]
]

{ #category : #accessing }
GtCompositePrefixTree >> first: anInteger [
	^ self first: anInteger startingWith: ''
]

{ #category : #accessing }
GtCompositePrefixTree >> first: anInteger startingWith: aString [
	| results |
	results := Set new.
	trees
		do:
			[ :each | results addAll: (each first: anInteger startingWith: aString) ].
	results := results asSortedCollection.
	^ results size > anInteger
		ifTrue: [ results first: anInteger ]
		ifFalse: [ results ]
]

{ #category : #removing }
GtCompositePrefixTree >> remove: oldObject ifAbsent: anExceptionBlock [ 
	self error: 'Cannot remove old object'
]

{ #category : #enumerating }
GtCompositePrefixTree >> species [
	^ OrderedCollection
]

{ #category : #'initialize-release' }
GtCompositePrefixTree >> trees: aCollection [
	trees := aCollection
]

{ #category : #accessing }
GtCompositePrefixTree >> weightedFirst: anInteger [
	^ self weightedFirst: anInteger startingWith: ''
]

{ #category : #accessing }
GtCompositePrefixTree >> weightedFirst: anInteger startingWith: aString [
	| results sorted |
	results := Dictionary new.
	trees
		do: [ :tree | 
			(tree weightedFirst: anInteger startingWith: aString)
				do: [ :each | results at: each put: 0 ] ].
	results
		keysDo: [ :key | 
			results
				at: key
				put: (trees inject: 0 into: [ :sum :each | sum + (each weightOf: key) ]) ].
	sorted := results associations
		asSortedCollection:
			[ :a :b | a value > b value or: [ a value = b value and: [ a key > b key ] ] ].
	^ (sorted size > anInteger
		ifTrue: [ sorted first: anInteger ]
		ifFalse: [ sorted ]) collect: [ :each | each key ]
]
