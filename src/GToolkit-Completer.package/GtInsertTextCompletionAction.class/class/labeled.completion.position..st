instance creation
labeled: aString completion: completionString position: anInteger
	^ (self labeled: aString)
		text: completionString;
		position: anInteger;
		yourself