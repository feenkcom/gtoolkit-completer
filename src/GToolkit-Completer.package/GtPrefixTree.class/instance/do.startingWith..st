iterating
do: aBlock startingWith: aString
	self nodeFor: aString startingAt: 1 do: [ :node :nodePrefix | node privateDo: aBlock withPrefix: nodePrefix ]