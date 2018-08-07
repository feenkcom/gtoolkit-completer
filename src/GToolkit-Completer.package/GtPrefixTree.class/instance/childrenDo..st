private
childrenDo: aBlock
	children isNil
		ifTrue: [ ^ self ].
	children do: aBlock