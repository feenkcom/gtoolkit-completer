smalltalk
smalltalkCompleter
	<gtExample>
	| text styler editor editorElement completionStrategy completionController |
	text := '' asRopedText.
	text
		attributes:
			{BrFontGenericFamilyAttribute monospace beNotOverwritableByStyler.
			(BrFontSizeAttribute size: 14) beNotOverwritableByStyler}.
	styler := BrRBTextStyler new.
	styler classOrMetaClass: GtPharoCompletionStrategy.
	editor := BrTextEditor new.
	editor styler: styler.
	editor text: text.
	editorElement := BrEditorElement new.
	editorElement
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	editorElement editor: editor.
	completionStrategy := GtPharoCompletionStrategy newForMethod.
	completionStrategy classOrMetaClass: GtPharoCompletionStrategy.
	completionController := GtCompletionController on: editorElement strategy: completionStrategy.
	completionController install.
	^ editorElement