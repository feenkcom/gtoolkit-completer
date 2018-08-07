private
splitAt: anInteger
	| newChild |
	newChild := self class new.
	newChild children: children.
	newChild weight: weight.
	newChild maxWeight: maxWeight.
	newChild prefix: (prefix copyFrom: anInteger to: prefix size).
	weight := 0.
	children := nil.
	prefix := prefix copyFrom: 1 to: anInteger - 1.
	self ensureChildren.
	children add: newChild