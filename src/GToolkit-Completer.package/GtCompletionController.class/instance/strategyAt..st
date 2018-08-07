private
strategyAt: anIndex
	| result |
	result := strategy.
	(self text attributesAt: anIndex)
		do: [ :each | 
			(each isKindOf: GtCompletionStrategyAttribute)
				ifTrue: [ result := each strategy ] ].
	^ result