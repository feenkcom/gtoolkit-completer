private
privateIncludes: aString startingAt: anIndex
	| nextIndex |
	prefix size > (aString size - anIndex + 1)
		ifTrue: [ ^ false ].
	1 to: prefix size do: [ :i | 
		(prefix at: i) = (aString at: anIndex + i - 1)
			ifFalse: [ ^ false ] ].
	nextIndex := anIndex + prefix size.
	nextIndex > aString size
		ifTrue: [ ^ weight > 0 ].
	self
		childrenDo: [ :each | 
			(each privateIncludes: aString startingAt: nextIndex)
				ifTrue: [ ^ true ] ].
	^ false