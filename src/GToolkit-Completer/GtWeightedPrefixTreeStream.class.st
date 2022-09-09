Class {
	#name : #GtWeightedPrefixTreeStream,
	#superclass : #GtAbstractPrefixTreeStream,
	#instVars : [
		'maxHeap',
		'nodeHeap'
	],
	#category : #'GToolkit-Completer-PrefixTree'
}

{ #category : #private }
GtWeightedPrefixTreeStream >> createInitialHeaps [
	maxHeap := Heap
			sortBlock: [ :a :b | 
				a first maxWeight > b first maxWeight
					or: [ a first weight = b first weight and: [ a last < b last ] ] ].
	nodeHeap := Heap
			sortBlock: [ :a :b | 
				a first weight > b first weight
					or: [ a first weight = b first weight and: [ a last < b last ] ] ].
	self
		nodesDo: [ :node :prefixString | 
			maxHeap
				add: {node.
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
