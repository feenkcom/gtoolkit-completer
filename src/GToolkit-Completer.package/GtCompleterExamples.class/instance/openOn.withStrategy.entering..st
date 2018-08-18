private
openOn: aString withStrategy: aCompletionStrategy entering: anArray
	| editorElement completionController delay |
	editorElement := self editorElementFor: aString.
	BlElement new addChild: editorElement.
	completionController := GtCompletionController on: editorElement strategy: aCompletionStrategy.
	completionController install.
	completionController instVarNamed: 'cursorElement' put: editorElement.
	[ delay := GtCompletionController popupDelayMilliseconds.
	GtCompletionController popupDelayMilliseconds: 2.
	[ self enter: anArray into: completionController.
	self pauseForCompletion ]
		ensure: [ GtCompletionController popupDelayMilliseconds: delay ] ] fork.
	^ completionController