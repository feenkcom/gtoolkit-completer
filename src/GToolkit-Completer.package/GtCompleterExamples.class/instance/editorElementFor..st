private
editorElementFor: aString
	| editor editorElement text |
	text := aString asRopedText.
	editor := BrTextEditor new.
	editor text: text.
	editorElement := BrEditorElement new.
	editorElement editor: editor.
	^ editorElement