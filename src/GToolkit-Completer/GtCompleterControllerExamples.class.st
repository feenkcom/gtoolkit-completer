Class {
	#name : #GtCompleterControllerExamples,
	#superclass : #Object,
	#instVars : [
		'space'
	],
	#category : #'GToolkit-Completer-Examples'
}

{ #category : #strategies }
GtCompleterControllerExamples >> alphabetStrategy [
	<gtExample>
	| strategy tree |
	tree := GtPrefixTree new.
	$a asInteger to: $z asInteger do: [ :i | tree add: (String new: i - $a asInteger + 1 withAll: (Character value: i)) ].
	strategy := GtStringsCompletionStrategy new.
	strategy completions: tree.
	^ strategy
]

{ #category : #completing }
GtCompleterControllerExamples >> completeWithCursorMove [
	<gtExample>
	| aCompleter |
	
	aCompleter := self
		openOn: '12345'
		withStrategy: self alphabetStrategy.
	self enter: #(0 $b 4) into: aCompleter.
	
	self assert: aCompleter textEditor text asString equals: 'b12345'.
	self
		assert: (aCompleter textEditor cursors allCursors collect: #position)
		equals: #(4).
	self assert: aCompleter textEditor selection isEmpty.
	
	^ aCompleter
]

{ #category : #completing }
GtCompleterControllerExamples >> completionPreview [
	<gtExample>
	| aCompleter |
	
	aCompleter := self openOn: '' withStrategy: self alphabetStrategy.
	self enter: #(0 $c) into: aCompleter.
	
	self assert: aCompleter textEditor text asString equals: 'c'.
	self
		assert: (aCompleter textEditor cursors allCursors collect: #position)
		equals: #(1).
	self assert: aCompleter textEditor selection isEmpty.
	
	^ aCompleter
]

{ #category : #private }
GtCompleterControllerExamples >> editorElementFor: aString [
	| editor editorElement text |
	text := aString asRopedText.
	editor := BrTextEditorModel new.
	editor text: text.
	editorElement := BrEditorElement new.
	editorElement editor: editor.
	editorElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	^ editorElement
]

{ #category : #private }
GtCompleterControllerExamples >> enter: anArray into: completionController [
	anArray
		do: [ :each | 
			each isInteger
				ifTrue: [ self moveCursorTo: each on: completionController ].
			each isString
				ifTrue: [ each isSymbol
						ifTrue: [ self perform: each with: completionController ]
						ifFalse: [ self insertString: each on: completionController ] ].
			each isCharacter
				ifTrue: [ self insertString: (String with: each) on: completionController ].
			each isBlock
				ifTrue: [ self pauseForCompletion.
					each value: completionController ] ]
]

{ #category : #private }
GtCompleterControllerExamples >> insertString: aString on: completionController [

	"inserter deletes selected text by default"
	completionController textEditor inserter
		atCursor;
		string: aString;
		insert
]

{ #category : #private }
GtCompleterControllerExamples >> moveCursorTo: anInteger on: aCompletionController [
	self pauseForCompletion.
	aCompletionController textEditor moveCursorTo: anInteger
]

{ #category : #'examples - scripter' }
GtCompleterControllerExamples >> move_cursor_to_end [
	<gtExample>
	| aScripter |
	
	aScripter := self request_focus.
	
	aScripter substep: 'Move cursor' do: [ :aStep |
		aStep keyClick: BlKeyboardKey arrowRight.
		aStep keyClick: BlKeyboardKey arrowRight ].
	
	^ aScripter syncContinue
]

{ #category : #private }
GtCompleterControllerExamples >> openOn: aString withStrategy: aCompletionStrategy [
	| editorElement completionController |
	
	editorElement := self editorElementFor: aString.
	"editor must have focus for cursor to appear"
	editorElement requestFocus.

	completionController := GtCompletionController on: editorElement strategy: aCompletionStrategy.
	completionController install.

	space := BlSpace new.
	space host: BlHeadlessHost new.
	"simulated time allows us to instantly advance space time by a given duration without using forks"
	space time: BlTime simulated.
	space addChild: editorElement.

	^ completionController
]

{ #category : #private }
GtCompleterControllerExamples >> pauseForCompletion [
	"advance time by popup delay (instantly)"
	space time wait: GtCompletionController popupDelay.
	"perform one more frame"
	space pulse
]

{ #category : #'examples - scripter' }
GtCompleterControllerExamples >> remove_last_character_while_completion_is_about_to_appear [
	<gtExample>
	| aScripter |
	
	aScripter := self move_cursor_to_end.
	
	aScripter type
		label: 'Type e to start completion';
		text: 'e';
		onSelf;
		play.

	aScripter keyClick
		label: 'Remove last character';
		key: BlKeyboardKey backspace;
		play.
		
	aScripter type
		label: 'Type e to start completion';
		text: 'e';
		onSelf;
		play.
		
	aScripter keyClick
		label: 'Remove last character';
		key: BlKeyboardKey backspace;
		play.
	
	^ aScripter
]

{ #category : #'examples - scripter' }
GtCompleterControllerExamples >> request_focus [
	<gtExample>
	| aScripter |
	
	aScripter := self scripterWithCompletion.
	
	aScripter substep: 'Request focus' do: [ :aStep |
		aStep
			requestFocus;
			onSelf ].
	
	^ aScripter syncContinue
]

{ #category : #'instance creation' }
GtCompleterControllerExamples >> scripter [
	<gtExample>
	
	^ BlDevScripter new
]

{ #category : #'instance creation' }
GtCompleterControllerExamples >> scripterElement [
	<gtExample>
	| anEditor aCompletionController |
	
	anEditor := BrEditor new
		aptitude: BrGlamorousCodeEditorAptitude new + BrGlamorousTextAreaSpacingAptitude new;
		text: 'ee'.
	
	aCompletionController := GtCompletionController on: anEditor strategy: self alphabetStrategy.
	aCompletionController install.

	^ anEditor
]

{ #category : #'instance creation' }
GtCompleterControllerExamples >> scripterWithCompletion [
	<gtExample>
	| aScripter anEditor |
	
	aScripter := self scripter.
	anEditor := self scripterElement.	
	aScripter element: anEditor.

	^ aScripter
]

{ #category : #private }
GtCompleterControllerExamples >> selectPreviewMatching: aString in: completionController [
	self pauseForCompletion.
	completionController completionResult stream asyncSimilarCopy isNotEmpty wait
		ifFalse: [ ^ self error: 'No completion actions' ].
	100
		timesRepeat: [ completionController
				selectedCompletionItemDo: [ :aCompletionItem | 
					(aString match: aCompletionItem label)
						ifTrue: [ ^ self ] ].
			completionController selectNextItem ].
	self error: 'Could not find completion action'
]

{ #category : #private }
GtCompleterControllerExamples >> tabComplete: completionController [
	self pauseForCompletion.
	completionController completeWithCursor: true
]

{ #category : #private }
GtCompleterControllerExamples >> tabNext: completionController [
	completionController processTabKey: true
]
