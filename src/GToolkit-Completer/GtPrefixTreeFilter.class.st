Class {
	#name : #GtPrefixTreeFilter,
	#superclass : #Object,
	#instVars : [
		'tree',
		'filter'
	],
	#category : #'GToolkit-Completer-PrefixTree'
}

{ #category : #accessing }
GtPrefixTreeFilter >> asyncStreamStartingWith: aString [
	^ (tree asyncStreamStartingWith: aString) filter: filter
]

{ #category : #accessing }
GtPrefixTreeFilter >> asyncStreamStartingWith: aString caseSensitive: aBoolean [
	^ (tree asyncStreamStartingWith: aString caseSensitive: aBoolean)
		filter: filter
]

{ #category : #accessing }
GtPrefixTreeFilter >> asyncWeightedStreamStartingWith: aString [
	^ (tree asyncWeightedStreamStartingWith: aString) filter: filter
]

{ #category : #accessing }
GtPrefixTreeFilter >> asyncWeightedStreamStartingWith: aString caseSensitive: aBoolean [
	^ (tree asyncWeightedStreamStartingWith: aString caseSensitive: aBoolean)
		filter: filter
]

{ #category : #accessing }
GtPrefixTreeFilter >> do: aBlock [
	^ tree do: [ :each | (filter value: each) ifTrue: [ aBlock value: each ] ]
]

{ #category : #accessing }
GtPrefixTreeFilter >> do: aBlock startingWith: aString [
	^ tree
		do: [ :each | (filter value: each) ifTrue: [ aBlock value: each ] ]
		startingWith: aString
]

{ #category : #accessing }
GtPrefixTreeFilter >> filter [
	^ filter
]

{ #category : #accessing }
GtPrefixTreeFilter >> filter: anObject [
	filter := anObject
]

{ #category : #accessing }
GtPrefixTreeFilter >> first: anInteger [
	^ self first: anInteger startingWith: ''
]

{ #category : #accessing }
GtPrefixTreeFilter >> first: anInteger startingWith: aString [
	| result |
	result := OrderedCollection new: anInteger.
	anInteger < 1 ifTrue: [ ^ result ].
	tree
		do: [ :each | 
			result add: each.
			result size = anInteger ifTrue: [ ^ result ] ]
		startingWith: aString.
	^ result
]

{ #category : #accessing }
GtPrefixTreeFilter >> gtItemsFor: aView [
	<gtView>
	^ aView list
		title: 'Items';
		items: [ self asyncStreamStartingWith: '' ]
]

{ #category : #testing }
GtPrefixTreeFilter >> includes: aString [
	^ (tree includes: aString) and: [ filter value: aString ]
]

{ #category : #testing }
GtPrefixTreeFilter >> isEmpty [
	self do: [ :each | ^ false ].
	^ true
]

{ #category : #accessing }
GtPrefixTreeFilter >> select: aBlock [
	^ self class new
		tree: tree;
		filter: [ :each | (filter value: each) and: [ aBlock value: each ] ];
		yourself
]

{ #category : #accessing }
GtPrefixTreeFilter >> tree [
	^ tree
]

{ #category : #accessing }
GtPrefixTreeFilter >> tree: anObject [
	tree := anObject
]

{ #category : #accessing }
GtPrefixTreeFilter >> weightedDo: aBlock [
	^ tree
		weightedDo: [ :each | (filter value: each) ifTrue: [ aBlock value: each ] ]
]

{ #category : #accessing }
GtPrefixTreeFilter >> weightedDo: aBlock startingWith: aString [
	^ tree
		weightedDo: [ :each | (filter value: each) ifTrue: [ aBlock value: each ] ]
		startingWith: aString
]

{ #category : #accessing }
GtPrefixTreeFilter >> weightedFirst: anInteger [
	^ self weightedFirst: anInteger startingWith: ''
]

{ #category : #accessing }
GtPrefixTreeFilter >> weightedFirst: anInteger startingWith: aString [
	| result |
	result := OrderedCollection new: anInteger.
	anInteger < 1 ifTrue: [ ^ result ].
	tree
		weightedFirst: [ :each | 
			result add: each.
			result size = anInteger ifTrue: [ ^ result ] ]
		startingWith: aString.
	^ result
]
