accessing
weightedFirst: anInteger startingWith: aString
	"Return the first anInteger (or less) items starting with aString -- order by largest weight first"

	| items |
	items := OrderedCollection new: anInteger.
	self
		weightedDo: [ :each | 
			items add: each.
			items size = anInteger
				ifTrue: [ ^ items ] ]
		startingWith: aString.
	^ items