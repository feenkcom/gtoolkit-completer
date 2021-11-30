Class {
	#name : #GtPrefixTreeStream,
	#superclass : #Object,
	#traits : 'TAsyncStream',
	#classTraits : 'TAsyncStream classTrait',
	#instVars : [
		'root',
		'prefix',
		'stack'
	],
	#category : #'GToolkit-Completer'
}

{ #category : #'instance creation' }
GtPrefixTreeStream class >> tree: aPrefixTree prefix: aString [
	^ (self new)
		tree: aPrefixTree prefix: aString;
		yourself
]

{ #category : #private }
GtPrefixTreeStream >> createInitialStack [
	stack := Stack new.
	root
		findNode: prefix
		current: ''
		do:
			[ :node :prefixString | 
			stack
				push:
					{node.
						prefixString} ]
]

{ #category : #'api - stream' }
GtPrefixTreeStream >> pollNext: anAsynchronousContext [
	stack isNil ifTrue: [ self createInitialStack ].
	[ | current name |
	stack isEmpty ifTrue: [ ^ AsyncPoll ready: AsyncOptionalValue none ].
	current := stack pop.
	name := current last , current first prefix.
	(current first children ifNil: [ #() ])
		reverseDo:
			[ :each | 
			stack
				push:
					{each.
						name} ].
	current first weight > 0 ifTrue: [ ^ AsyncPoll ready: (AsyncOptionalValue some: name) ] ] repeat
]

{ #category : #'api - stream copy' }
GtPrefixTreeStream >> postSimilarCopy [
	stack := nil
]

{ #category : #'initialize-release' }
GtPrefixTreeStream >> tree: aPrefixTree prefix: aString [
	root := aPrefixTree.
	prefix := aString
]
