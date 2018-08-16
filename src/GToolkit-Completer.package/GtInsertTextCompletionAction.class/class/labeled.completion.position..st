instance creation
labeled: aString completion: completionString position: anInteger
	^ self
		labeled: aString
		completion: completionString
		position: anInteger
		from: anInteger - aString size + completionString size