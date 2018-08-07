initialize-release
initialize
	super initialize.
	strategy := GtCompletionStrategy new.
	overlay := GtCompletionOverlayElement new.
	overlay clipChildren: true.
	listElement := BrSimpleList new.
	listElement
		border: (BlBorder paint: Color lightGray width: 1);
		display: #();
		stencil: [ :each :anIndex | BrListLabelStencil new text: each displayString ].
	overlay addChild: listElement.
	lastWasText := false.
	ignoreTextChangeEvent := false