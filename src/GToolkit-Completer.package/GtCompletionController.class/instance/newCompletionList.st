private - instance creation
newCompletionList
	<return: #BrSimpleList>
	
	^ BrSimpleList new
		background: Color white;
		border: (BlBorder paint: Color lightGray width: 1);
		padding: (BlInsets all: 2);
		display: #();
		stencil: [ :each :anIndex | BrListLabelStencil new text: (each displayString asRopedText thin monospace) ]