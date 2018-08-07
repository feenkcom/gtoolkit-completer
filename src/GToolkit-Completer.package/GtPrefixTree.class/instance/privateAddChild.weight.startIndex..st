private
privateAddChild: aString weight: aNumber startIndex: anIndex
	| char node |
	anIndex > aString size
		ifTrue: [ ^ self weight: weight + aNumber ].
	self ensureChildren.
	char := aString at: anIndex.
	children
		do: [ :each | 
			each prefix first = char
				ifTrue: [ each privateAdd: aString weight: aNumber startIndex: anIndex.
					maxWeight := maxWeight max: each maxWeight.
					^ self ] ].
	node := self class new.
	node
		prefix: (aString copyFrom: anIndex to: aString size);
		weight: aNumber.
	children add: node.
	maxWeight := maxWeight max: node maxWeight