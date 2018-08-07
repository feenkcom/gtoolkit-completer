comparing
= anObject
	^ super = anObject and: [ self text = anObject text and: [ self position = anObject position ] ]