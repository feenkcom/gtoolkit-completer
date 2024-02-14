Class {
	#name : #GtPrefixTree,
	#superclass : #Collection,
	#instVars : [
		'prefix',
		'weight',
		'children',
		'maxWeight'
	],
	#category : #'GToolkit-Completer-PrefixTree'
}

{ #category : #'instance creation' }
GtPrefixTree class >> new: anInteger [
	^ self new
]

{ #category : #adding }
GtPrefixTree >> add: aString [
	self add: aString weight: 1
]

{ #category : #adding }
GtPrefixTree >> add: aString weight: aNumber [
	^ self
		privateAdd: aString
		weight: aNumber
		startIndex: 1
]

{ #category : #enumerating }
GtPrefixTree >> allNodesDo: aBlock [
	aBlock value: self.
	self childrenDo: [ :each | each allNodesDo: aBlock ]
]

{ #category : #iterating }
GtPrefixTree >> asyncStreamStartingWith: aString [
	^ GtPrefixTreeStream tree: self prefix: aString
]

{ #category : #iterating }
GtPrefixTree >> asyncStreamStartingWith: aString caseSensitive: aBoolean [
	^ GtPrefixTreeStream
		tree: self
		prefix: aString
		caseSensitive: aBoolean
]

{ #category : #iterating }
GtPrefixTree >> asyncWeightedStreamStartingWith: aString [
	^ GtWeightedPrefixTreeStream tree: self prefix: aString
]

{ #category : #iterating }
GtPrefixTree >> asyncWeightedStreamStartingWith: aString caseSensitive: aBoolean [
	^ GtWeightedPrefixTreeStream
		tree: self
		prefix: aString
		caseSensitive: aBoolean
]

{ #category : #accessing }
GtPrefixTree >> cacheSizeInMemory [
	| strings size |
	size := 0.
	strings := IdentitySet new.
	
	self allNodesDo: [ :each | 
		each prefix isSymbol ifFalse: [ 
			strings add: each prefix ] ].
	size := size + self gtSpecificSizeInMemory .
	
	strings do: [ :each | size := size + each sizeInMemory ].
	^ size
]

{ #category : #private }
GtPrefixTree >> children [
	^ children
]

{ #category : #private }
GtPrefixTree >> children: anObject [
	children := anObject
]

{ #category : #private }
GtPrefixTree >> childrenDo: aBlock [
	children isNil
		ifTrue: [ ^ self ].
	children do: aBlock
]

{ #category : #enumerating }
GtPrefixTree >> collect: aBlock [
	| result |
	result := OrderedCollection new.
	self do: [ :each | result add: (aBlock value: each) ].
	^ result
]

{ #category : #private }
GtPrefixTree >> compressData [
]

{ #category : #iterating }
GtPrefixTree >> do: aBlock [
	self privateDo: aBlock withPrefix: ''
]

{ #category : #iterating }
GtPrefixTree >> do: aBlock startingWith: aString [
	self nodeFor: aString startingAt: 1 do: [ :node :nodePrefix | node privateDo: aBlock withPrefix: nodePrefix ]
]

{ #category : #private }
GtPrefixTree >> ensureChildren [
	children isNil ifTrue: [ children := OrderedCollection new: 2 ]
]

{ #category : #enumerating }
GtPrefixTree >> exactMatchFor: prefixString caseSensitive: aBoolean [
	self
		findNodes: prefixString
		caseSensitive: aBoolean
		current: ''
		do: [ :node :string | 
			node weight > 0
				ifTrue: [ | name |
					name := string , node prefix.
					(name sameAs: prefixString) ifTrue: [ ^ name ] ] ].
	^ nil
]

{ #category : #enumerating }
GtPrefixTree >> findNode: prefixString current: currentPrefix do: aBlock [
	| index child |
	index := currentPrefix size + prefix size.
	index < prefixString size
		ifTrue:
			[ child := (children ifNil: [ #() ])
				detect:
					[ :each | each prefix beginsWith: (prefixString copyFrom: index + 1 to: (each prefix size + index min: prefixString size)) ]
				ifNone: [ ^ self ].
			^ child
				findNode: prefixString
				current: currentPrefix , prefix
				do: aBlock ].
	aBlock value: self value: currentPrefix
]

{ #category : #enumerating }
GtPrefixTree >> findNodes: prefixString caseSensitive: aBoolean current: currentPrefix do: aBlock [
	| index |
	index := currentPrefix size + prefix size.
	index < prefixString size
		ifTrue: [ (children ifNil: [ #() ])
				do: [ :each | 
					(each prefix
						beginsWith: (prefixString
								copyFrom: index + 1
								to: (each prefix size + index min: prefixString size))
						caseSensitive: aBoolean)
						ifTrue: [ each
								findNodes: prefixString
								caseSensitive: aBoolean
								current: currentPrefix , prefix
								do: aBlock.
							aBoolean ifTrue: [ ^ self ] ] ] ]
		ifFalse: [ aBlock value: self value: currentPrefix ]
]

{ #category : #accessing }
GtPrefixTree >> first: anInteger [
	^ self first: anInteger startingWith: ''
]

{ #category : #accessing }
GtPrefixTree >> first: anInteger startingWith: aString [
	"Return the first anInteger (or less) items starting with aString"

	| items |
	items := OrderedCollection new: anInteger.
	self
		do: [ :each | 
			items add: each.
			items size = anInteger
				ifTrue: [ ^ items ] ]
		startingWith: aString.
	^ items
]

{ #category : #accessing }
GtPrefixTree >> gtLocalSizeInMemory [
	"This doesn't add the prefix string to the size as those can be shared"

	| size |
	size := self sizeInMemory.
	children ifNotNil: [ :col | size := size + col gtSpecificSizeInMemory ].
	^ size
]

{ #category : #accessing }
GtPrefixTree >> gtSpecificSizeInMemory [
	| size |
	size := 0.
	self allNodesDo: [ :each | size := size + each gtLocalSizeInMemory ].
	^ size
]

{ #category : #ui }
GtPrefixTree >> gtViewChildrenFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Children trees' translated;
		items: [ {self} ];
		children: [ :each | each children ifNil: [ #() ] ];
		column: 'Prefix' text: [ :aPrefixTree | aPrefixTree prefix ];
		column: 'Tree' text: [ :aPrefixTree | aPrefixTree ]
]

{ #category : #'private-testing' }
GtPrefixTree >> hasChildren [
	^ children notNil and: [ children notEmpty ]
]

{ #category : #testing }
GtPrefixTree >> includes: aString [
	^ self privateIncludes: aString startingAt: 1
]

{ #category : #'initialize-release' }
GtPrefixTree >> initialize [
	super initialize.
	prefix := ''.
	weight := maxWeight := 0
]

{ #category : #testing }
GtPrefixTree >> isEmpty [
	^ maxWeight = 0
]

{ #category : #private }
GtPrefixTree >> maxWeight [
	^ maxWeight
]

{ #category : #private }
GtPrefixTree >> maxWeight: anObject [
	^ maxWeight := anObject
]

{ #category : #private }
GtPrefixTree >> moveDataTo: newChild [
]

{ #category : #accessing }
GtPrefixTree >> nodeFor: aString [
	self
		nodeFor: aString
		startingAt: 1
		do: [ :node :pre | (pre , node prefix) = aString ifTrue: [ ^ node ] ].
	^ nil
]

{ #category : #private }
GtPrefixTree >> nodeFor: aString startingAt: anIndex do: aBlock [
	| nextIndex |
	anIndex > aString size
		ifTrue: [ ^ aBlock value: self value: (aString copyFrom: 1 to: anIndex - 1) ].
	1 to: (prefix size min: aString size - anIndex + 1) do: [ :i | 
		(prefix at: i) = (aString at: anIndex + i - 1)
			ifFalse: [ ^ self ] ].
	prefix size > (aString size - anIndex + 1)
		ifTrue: [ ^ aBlock value: self value: (aString copyFrom: 1 to: anIndex - 1) ].
	nextIndex := anIndex + prefix size.
	nextIndex > aString size
		ifTrue: [ ^ aBlock value: self value: (aString copyFrom: 1 to: anIndex - 1) ].
	self
		childrenDo: [ :each | 
			each prefix first = (aString at: nextIndex)
				ifTrue: [ ^ each nodeFor: aString startingAt: nextIndex do: aBlock ] ].
	^ self
]

{ #category : #private }
GtPrefixTree >> prefix [
	^ prefix
]

{ #category : #private }
GtPrefixTree >> prefix: aString [
	prefix := aString size <= 2
		ifTrue: [ aString asSymbol ]
		ifFalse: [ aString ]
]

{ #category : #private }
GtPrefixTree >> privateAdd: aString weight: aNumber startIndex: anInteger [
	| aStringIndex myIndex |
	myIndex := 1.
	aStringIndex := anInteger.
	[ myIndex > prefix size
		ifTrue: [ ^ self privateAddChild: aString weight: aNumber startIndex: aStringIndex ].
	(aStringIndex > aString size or: [ (aString at: aStringIndex) ~~ (prefix at: myIndex) ])
		ifTrue: [ self splitAt: myIndex.
			^ self privateAddChild: aString weight: aNumber startIndex: aStringIndex ].
	myIndex := myIndex + 1.
	aStringIndex := aStringIndex + 1.
	true ] whileTrue
]

{ #category : #private }
GtPrefixTree >> privateAddChild: aString weight: aNumber startIndex: anIndex [
	| char node first last |
	anIndex > aString size ifTrue: [ ^ self weight: weight + aNumber ].
	self ensureChildren.
	char := aString at: anIndex.
	first := 1.
	last := children size.
	[ first <= last ]
		whileTrue: [ | child mid childPrefix |
			mid := first + last bitShift: -1.
			child := children at: mid.
			childPrefix := child prefix first.
			childPrefix = char
				ifTrue: [ node := child
							privateAdd: aString
							weight: aNumber
							startIndex: anIndex.
					maxWeight := maxWeight max: child maxWeight.
					^ node ].
			childPrefix < char ifTrue: [ first := mid + 1 ] ifFalse: [ last := mid - 1 ] ].
	node := self class new.
	node
		prefix: (aString copyFrom: anIndex to: aString size);
		weight: aNumber.
	children add: node beforeIndex: first.
	maxWeight := maxWeight max: node maxWeight.
	^ node
]

{ #category : #private }
GtPrefixTree >> privateDo: aBlock withPrefix: aString [
	| label |
	label := aString , prefix.
	weight > 0
		ifTrue: [ aBlock
				cull: label
				cull: weight
				cull: self ].
	self childrenDo: [ :each | each privateDo: aBlock withPrefix: label ]
]

{ #category : #private }
GtPrefixTree >> privateIncludes: aString startingAt: anIndex [
	| nextIndex |
	prefix size > (aString size - anIndex + 1)
		ifTrue: [ ^ false ].
	1 to: prefix size do: [ :i | 
		(prefix at: i) = (aString at: anIndex + i - 1)
			ifFalse: [ ^ false ] ].
	nextIndex := anIndex + prefix size.
	nextIndex > aString size
		ifTrue: [ ^ weight > 0 ].
	self
		childrenDo: [ :each | 
			(each privateIncludes: aString startingAt: nextIndex)
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #private }
GtPrefixTree >> privateRemove: aString weight: aNumber startIndex: anInteger [
	| nextIndex char child result |
	nextIndex := anInteger + prefix size.
	nextIndex - 1 > aString size ifTrue: [ ^ nil ].
	prefix = (aString copyFrom: anInteger to: nextIndex - 1) ifFalse: [ ^ nil ].
	nextIndex > aString size
		ifTrue: [ weight := weight - aNumber max: 0.
			self updateMaxWeight.
			^ self ]
		ifFalse: [ char := aString at: nextIndex.
			self
				childrenDo: [ :each | 
					each prefix first = char
						ifTrue: [ result := each
									privateRemove: aString
									weight: aNumber
									startIndex: nextIndex.
							child := each ] ].
			self updateMaxWeight.
			(child notNil and: [ child maxWeight = 0 ])
				ifTrue: [ children remove: child ].
			^ result ]
]

{ #category : #private }
GtPrefixTree >> privateWeightedDo: aBlock withPrefix: aString [
	| weighted maxWeighted |
	weighted := Heap sortBlock: [ :a :b | a first weight > b first weight or: [ a first weight = b first weight and: [ a last < b last ] ] ].
	maxWeighted := Heap sortBlock: [ :a :b | a first maxWeight > b first maxWeight or: [ a first maxWeight = b first maxWeight and: [ a last < b last ] ] ].
	self
		nodeFor: aString
		startingAt: 1
		do: [ :node :nodePrefix | 
			maxWeighted
				add:
					{node.
					(nodePrefix , node prefix)} ].
	[ [ maxWeighted notEmpty and: [ weighted isEmpty or: [ weighted first first weight < maxWeighted first first maxWeight ] ] ]
		whileTrue: [ | entry |
			entry := maxWeighted removeFirst.
			entry first weight > 0
				ifTrue: [ weighted add: entry ].
			entry first
				childrenDo: [ :each | 
					maxWeighted
						add:
							{each.
							(entry last , each prefix)} ] ].
	weighted notEmpty ]
		whileTrue: [ | item |
			item := weighted removeFirst.
			aBlock cull: item last cull: item first weight ]
]

{ #category : #removing }
GtPrefixTree >> remove: aString [
	"Unlike normal collections, we don't throw an error if we remove something that isn't in the tree."

	self remove: aString weight: 1
]

{ #category : #removing }
GtPrefixTree >> remove: aString ifAbsent: aBlock [
	^ (self includes: aString)
		ifTrue: [ self remove: aString ]
		ifFalse: [ aBlock value ]
]

{ #category : #removing }
GtPrefixTree >> remove: aString weight: aNumber [
	^ self
		privateRemove: aString
		weight: aNumber
		startIndex: 1
]

{ #category : #enumerating }
GtPrefixTree >> select: aBlock [
	| result |
	result := self copyEmpty.
	self
		weightedDo: [ :each :w | 
			(aBlock value: each)
				ifTrue: [ result add: each weight: w ] ].
	^ result
]

{ #category : #accessing }
GtPrefixTree >> size [
	| count |
	count := 0.
	self do: [ :each | count := count + 1 ].
	^ count
]

{ #category : #private }
GtPrefixTree >> splitAt: anInteger [
	| newChild |
	newChild := self class new.
	newChild children: children.
	newChild weight: weight.
	newChild maxWeight: maxWeight.
	newChild prefix: (prefix copyFrom: anInteger to: prefix size).
	self moveDataTo: newChild.
	weight := 0.
	children := nil.
	self prefix: (prefix copyFrom: 1 to: anInteger - 1).
	self ensureChildren.
	children add: newChild
]

{ #category : #private }
GtPrefixTree >> updateMaxWeight [
	maxWeight := weight.
	self childrenDo: [ :each | maxWeight := maxWeight max: each maxWeight ]
]

{ #category : #private }
GtPrefixTree >> weight [
	^ weight
]

{ #category : #private }
GtPrefixTree >> weight: aNumber [
	weight := aNumber.
	maxWeight := maxWeight max: weight
]

{ #category : #accessing }
GtPrefixTree >> weightOf: aString [
	self
		weightedDo: [ :each :value | 
			each = aString
				ifTrue: [ ^ value ] ]
		startingWith: aString.
	^ 0
]

{ #category : #iterating }
GtPrefixTree >> weightedDo: aBlock [
	self privateWeightedDo: aBlock withPrefix: ''
]

{ #category : #iterating }
GtPrefixTree >> weightedDo: aBlock startingWith: aString [
	self privateWeightedDo: aBlock withPrefix: aString
]

{ #category : #accessing }
GtPrefixTree >> weightedFirst: anInteger [
	^ self weightedFirst: anInteger startingWith: ''
]

{ #category : #accessing }
GtPrefixTree >> weightedFirst: anInteger startingWith: aString [
	"Return the first anInteger (or less) items starting with aString -- order by largest weight first"

	| items |
	items := OrderedCollection new: anInteger.
	self
		weightedDo: [ :each | 
			items add: each.
			items size = anInteger
				ifTrue: [ ^ items ] ]
		startingWith: aString.
	^ items
]
