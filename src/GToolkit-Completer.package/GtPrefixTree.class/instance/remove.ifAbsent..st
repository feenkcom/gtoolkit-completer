removing
remove: aString ifAbsent: aBlock
	^ (self includes: aString)
		ifTrue: [ self remove: aString ]
		ifFalse: [ aBlock value ]