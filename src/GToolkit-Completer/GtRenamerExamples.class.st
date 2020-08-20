Class {
	#name : #GtRenamerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Completer-Examples'
}

{ #category : #accessing }
GtRenamerExamples >> applyRename [
	<gtExample>
	| scripter |
	scripter := self startRename.
	scripter
		substep: 'Delete char'
		do: [ :aStep | aStep keyClick: BlKeyboardKey backspace ].
	scripter syncContinue pulse.
	scripter
		substep: 'Apply rename'
		do: [ :aStep | aStep keyClick: BlKeyboardKey return ].
	scripter syncContinue.
	self
		assert:
			scripter element editor text asString
				= (self methodText copyReplaceAll: 'anInteger' with: 'aInteger').
	^ scripter
]

{ #category : #accessing }
GtRenamerExamples >> cancelRename [
	<gtExample>
	| scripter |
	scripter := self startRename.
	scripter
		substep: 'Delete char'
		do: [ :aStep | aStep keyClick: BlKeyboardKey backspace ].
	scripter syncContinue pulse.
	scripter
		substep: 'Cancel rename'
		do: [ :aStep | aStep keyClick: BlKeyboardKey escape ].
	scripter syncContinue.
	self assert: scripter element editor text asString = self methodText.
	^ scripter
]

{ #category : #examples }
GtRenamerExamples >> methodText [
	^ 'double: anInteger
	^ anInteger + anInteger'
]

{ #category : #examples }
GtRenamerExamples >> scripter [
	<gtExample>
	
	^ BlDevScripter new
]

{ #category : #examples }
GtRenamerExamples >> smalltalkRenamer [
	<gtExample>
	| text styler editorElement completionStrategy completionController |
	text := self methodText asRopedText.
	styler := BrRBTextStyler new.
	styler classOrMetaClass: GtPharoCompletionStrategy.
	editorElement := BrEditor new
		look: BrGlamorousCodeEditorLook new + BrGlamorousTextAreaSpacingLook new;
		styler: styler;
		text: text.
	editorElement editor
		addEditorShortcut:
			(BrTextEditorShortcut new
				combination: BlKeyCombination primaryR;
				action:
						[ :aShortcutEvent | GtRenameAction pharoRenameLocalsOn: aShortcutEvent currentTarget ]).
	completionStrategy := GtPharoCompletionStrategy newForMethod.
	completionStrategy classOrMetaClass: GtPharoCompletionStrategy.
	completionController := GtCompletionController
		on: editorElement
		strategy: completionStrategy.
	completionController install.
	^ editorElement
]

{ #category : #accessing }
GtRenamerExamples >> smalltalkRenamerScripter [
	<gtExample>
	| scripter |
	scripter := self scripter.
	scripter element: self smalltalkRenamer.
	^ scripter pulse
]

{ #category : #accessing }
GtRenamerExamples >> startRename [
	<gtExample>
	| scripter |
	scripter := self smalltalkRenamerScripter.
	scripter
		substep: 'Request focus'
		do: [ :aStep | 
			aStep
				requestFocus;
				onSelf ].
	scripter
		substep: 'Move cursor'
		do:
			[ :aStep | 10 timesRepeat: [ aStep keyClick: BlKeyboardKey arrowRight ] ].
	scripter
		substep: 'Start rename'
		do: [ :aStep | 
			aStep keyDown: BlKeyboardKey metaLeft.
			aStep keyClick: BlKeyboardKey r.
			aStep keyUp: BlKeyboardKey metaLeft ].
	^ scripter syncContinue pulse
]
