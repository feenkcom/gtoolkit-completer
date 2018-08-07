private
nodeFor: aString startingAt: anIndex do: aBlock
	| nextIndex |
	(anIndex > aString size or: [ prefix size > (aString size - anIndex + 1) ])
		ifTrue: [ ^ aBlock value: self value: (aString copyFrom: 1 to: anIndex - 1) ].
	1 to: prefix size do: [ :i | 
		(prefix at: i) = (aString at: anIndex + i - 1)
			ifFalse: [ ^ self ] ].
	nextIndex := anIndex + prefix size.
	nextIndex > aString size
		ifTrue: [ ^ aBlock value: self value: (aString copyFrom: 1 to: anIndex - 1) ].
	self
		childrenDo: [ :each | 
			each prefix first = (aString at: nextIndex)
				ifTrue: [ ^ each nodeFor: aString startingAt: nextIndex do: aBlock ] ].
	^ self