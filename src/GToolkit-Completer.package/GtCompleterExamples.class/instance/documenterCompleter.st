documenter
documenterCompleter
	<gtExample>
	| editor completionStrategy completionController |
	editor := GtDocumenter editorForText: ''.
	completionStrategy := GtPDocumenterCompletionStrategy new.
	completionController := GtCompletionController on: editor contentElement strategy: completionStrategy.
	completionController install.
	^ editor