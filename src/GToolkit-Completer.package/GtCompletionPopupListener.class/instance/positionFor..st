geometry
positionFor: anElement
	<return: #Point>
	| boundsInSpace |
	self
		assert: [ anElement isNotNil ]
		description: [ 'Reference element must not be nil' ].
	
	boundsInSpace := anElement bounds inSpace.
	
	^ (self overlayElement globalPointToParent: boundsInSpace position + boundsInSpace extent)