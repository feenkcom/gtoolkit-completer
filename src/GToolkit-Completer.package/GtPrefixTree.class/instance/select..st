enumerating
select: aBlock
	| result |
	result := self copyEmpty.
	self
		weightedDo: [ :each :w | 
			(aBlock value: each)
				ifTrue: [ result add: each weight: w ] ].
	^ result