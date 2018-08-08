private
nodeFor: anInteger in: anAST
	| node |
	anAST
		withAllNodesDo: [ :each | 
			(anInteger between: each startPosition and: each stopPosition)
				ifTrue: [ node := each ] ].
	^ node