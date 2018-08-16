instance creation
labeled: aString completion: completionString position: anInteger from: searchStartInteger
	^ (self labeled: aString)
		text: completionString;
		position: anInteger;
		searchStartPosition: searchStartInteger;
		yourself