private
ensureChildren
	children isNil
		ifTrue: [ children := SortedCollection new: 2.
			children sortBlock: [ :a :b | a prefix < b prefix ] ]