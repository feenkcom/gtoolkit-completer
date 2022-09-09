Class {
	#name : #GtPrefixTreeStream,
	#superclass : #GtAbstractPrefixTreeStream,
	#instVars : [
		'stack'
	],
	#category : #'GToolkit-Completer-PrefixTree'
}

{ #category : #private }
GtPrefixTreeStream >> createInitialStack [
	stack := Stack new.
	self
		nodesDo: [ :node :prefixString | 
			stack
				push: {node.
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
