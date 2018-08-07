private
privateRemove: aString weight: aNumber startIndex: anInteger
	| nextIndex char child |
	nextIndex := anInteger + prefix size.
	nextIndex - 1 > aString size
		ifTrue: [ ^ self ].
	prefix = (aString copyFrom: anInteger to: nextIndex - 1)
		ifFalse: [ ^ self ].
	nextIndex > aString size
		ifTrue: [ weight := weight - aNumber max: 0.
			self updateMaxWeight ]
		ifFalse: [ char := aString at: nextIndex.
			self
				childrenDo: [ :each | 
					each prefix first = char
						ifTrue: [ each privateRemove: aString weight: aNumber startIndex: nextIndex.
							child := each ] ].
			self updateMaxWeight.
			(child notNil and: [ child maxWeight = 0 ])
				ifTrue: [ children remove: child ] ]