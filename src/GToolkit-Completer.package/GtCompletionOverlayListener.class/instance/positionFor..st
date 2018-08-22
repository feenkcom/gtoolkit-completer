geometry
positionFor: anElement
	| topLeftCorner |
	
	topLeftCorner := (super positionFor: anElement).
	^ topLeftCorner + anElement bounds inSpace extent