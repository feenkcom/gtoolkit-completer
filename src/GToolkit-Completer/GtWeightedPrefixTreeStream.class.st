Class {
	#name : #GtWeightedPrefixTreeStream,
	#superclass : #Object,
	#traits : 'TAsyncStream',
	#classTraits : 'TAsyncStream classTrait',
	#instVars : [
		'root',
		'prefix',
		'maxHeap',
		'nodeHeap'
	],
	#category : #'GToolkit-Completer'
}

{ #category : #'instance creation' }
GtWeightedPrefixTreeStream class >> tree: aPrefixTree prefix: aString [
	^ (self new)
		tree: aPrefixTree prefix: aString;
		yourself
]

{ #category : #private }
GtWeightedPrefixTreeStream >> createInitialHeaps [
	maxHeap := Heap
		sortBlock:
			[ :a :b | a first maxWeight > b first maxWeight or: [ a first weight = b first weight and: [ a last < b last ] ] ].
	nodeHeap := Heap
		sortBlock: [ :a :b | a first weight > b first weight or: [ a first weight = b first weight and: [ a last < b last ] ] ].
	root
		findNode: prefix
		current: ''
		do:
			[ :node :prefixString | 
			maxHeap
				add:
					{node.
						prefixString} ]
]

{ #category : #'api - stream' }
GtWeightedPrefixTreeStream >> pollNext: anAsynchronousContext [
	| entry |
	maxHeap isNil ifTrue: [ self createInitialHeaps ].
	[ maxHeap notEmpty and: [ nodeHeap isEmpty or: [ maxHeap first first maxWeight > nodeHeap first first weight ] ] ]
		whileTrue:
			[ entry := maxHeap removeFirst.
			entry first weight > 0 ifTrue: [ nodeHeap add: entry ].
			entry first
				childrenDo:
					[ :each | 
					maxHeap
						add:
							{each.
								entry last , entry first prefix} ] ].
	^ nodeHeap isEmpty
		ifTrue: [ AsyncPoll ready: AsyncOptionalValue none ]
		ifFalse:
			[ entry := nodeHeap removeFirst.
			AsyncPoll ready: (AsyncOptionalValue some: entry last , entry first prefix) ]
]

{ #category : #'api - stream copy' }
GtWeightedPrefixTreeStream >> postSimilarCopy [
	nodeHeap := nil.
	maxHeap := nil
]

{ #category : #'initialize-release' }
GtWeightedPrefixTreeStream >> tree: aPrefixTree prefix: aString [
	root := aPrefixTree.
	prefix := aString
]
