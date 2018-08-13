class initialization
initialize
	ParameterValueCompletionSelectors := Dictionary new.
	ParameterValueCompletionSelectors
		at: GtPillarExampleAnnotation
			put:
			(Dictionary new
				at: #name put: #exampleMethodsStartingWith:;
				yourself);
		at: GtPillarEpiceaChangesAnnotation
			put:
			(Dictionary new
				at: #file put: #filenamesStartingWith:;
				yourself)