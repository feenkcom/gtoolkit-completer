private
openOn: aString withStrategy: aCompletionStrategy entering: anArray
	| editorElement completionController delay |
	editorElement := self editorElementFor: aString.
	BlElement new addChild: editorElement.
	completionController := GtCompletionController on: editorElement strategy: aCompletionStrategy.
	completionController install.
	completionController instVarNamed: 'cursorElement' put: editorElement.
	[ delay := GtCompletionController popupDelay.
	GtCompletionController popupDelay: 2 milliSeconds.
	[ self enter: anArray into: completionController.
	self pauseForCompletion ]
		ensure: [ GtCompletionController popupDelay: delay ] ] fork.
	^ completionController