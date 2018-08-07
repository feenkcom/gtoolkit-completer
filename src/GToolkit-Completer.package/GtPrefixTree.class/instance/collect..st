enumerating
collect: aBlock
	| result |
	result := OrderedCollection new.
	self do: [ :each | result add: (aBlock value: each) ].
	^ result