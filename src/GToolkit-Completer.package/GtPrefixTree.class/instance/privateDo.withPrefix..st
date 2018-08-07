private
privateDo: aBlock withPrefix: aString
	| label |
	label := aString , prefix.
	weight > 0
		ifTrue: [ aBlock cull: label cull: weight ].
	self childrenDo: [ :each | each privateDo: aBlock withPrefix: label ]