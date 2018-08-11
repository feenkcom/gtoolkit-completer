documenter
documenterCompleter
	<gtExample>
	| editorElement completionStrategy completionController |
	editorElement := GtDocumenter editorForText: ''.
	completionStrategy := GtPDocumenterCompletionStrategy new.
	completionController := GtCompletionController on: editorElement strategy: completionStrategy.
	completionController install.
	^ editorElement