private
privateAdd: aString weight: aNumber startIndex: anInteger
	| aStringIndex myIndex |
	myIndex := 1.
	aStringIndex := anInteger.
	[ myIndex > prefix size
		ifTrue: [ ^ self privateAddChild: aString weight: aNumber startIndex: aStringIndex ].
	(aStringIndex > aString size or: [ (aString at: aStringIndex) ~~ (prefix at: myIndex) ])
		ifTrue: [ self splitAt: myIndex.
			^ self privateAddChild: aString weight: aNumber startIndex: aStringIndex ].
	myIndex := myIndex + 1.
	aStringIndex := aStringIndex + 1.
	true ] whileTrue