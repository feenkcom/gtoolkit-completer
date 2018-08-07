testing
hasCompletionEntryFor: aString
	completions
		do: [ :each | 
			each ~= aString
				ifTrue: [ ^ true ] ]
		startingWith: aString.
	^ false