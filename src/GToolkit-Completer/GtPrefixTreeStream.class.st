Class {
	#name : #GtPrefixTreeStream,
	#superclass : #Object,
	#traits : 'TAsyncStream',
	#classTraits : 'TAsyncStream classTrait',
	#instVars : [
		'prefix',
		'stack',
		'root'
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
	| currentPrefix currentNode index char |
	stack := Stack new.
	currentPrefix := ''.
	currentNode := root.
	[ (index := currentPrefix size + currentNode prefix size) < prefix size ]
		whileTrue:
			[ char := prefix at: index + 1.
			currentPrefix := currentPrefix , currentNode prefix.
			currentNode := (currentNode children ifNil: [ #() ]) detect: [ :each | each prefix first = char ] ifNone: [ ^ self ] ].
	stack
		push:
			{currentNode.
				currentPrefix}
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
