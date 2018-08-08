private
nodeFor: anInteger in: anAST
	| node |
	anAST
		withAllNodesDo: [ :each | 
			(anInteger between: anAST startPosition and: anAST stopPosition)
				ifTrue: [ node := each ] ].
	^ node