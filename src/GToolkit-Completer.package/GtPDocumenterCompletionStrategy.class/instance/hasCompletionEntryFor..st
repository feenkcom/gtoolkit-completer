testing
hasCompletionEntryFor: aString
	annotationTags
		do: [ :each | 
			each ~= aString
				ifTrue: [ ^ true ] ]
		startingWith: aString.
	^ false