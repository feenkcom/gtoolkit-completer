accessing
first: anInteger startingWith: aString
	"Return the first anInteger (or less) items starting with aString"

	| items |
	items := OrderedCollection new: anInteger.
	self
		do: [ :each | 
			items add: each.
			items size = anInteger
				ifTrue: [ ^ items ] ]
		startingWith: aString.
	^ items