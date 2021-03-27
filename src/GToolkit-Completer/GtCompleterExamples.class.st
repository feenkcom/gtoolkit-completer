Class {
	#name : #GtCompleterExamples,
	#superclass : #Object,
	#instVars : [
		'space'
	],
	#category : #'GToolkit-Completer-Examples'
}

{ #category : #strategies }
GtCompleterExamples >> alphabetStrategy [
	<gtExample>
	| strategy tree |
	tree := GtPrefixTree new.
	$a asInteger to: $z asInteger do: [ :i | tree add: (String new: i - $a asInteger + 1 withAll: (Character value: i)) ].
	strategy := GtStringsCompletionStrategy new.
	strategy completions: tree.
	^ strategy
]

{ #category : #smalltalk }
GtCompleterExamples >> binaryCompletion [
	<gtExample>
	| text strategy |
	text := 'foo ^3 <'.
	strategy := self smalltalkStrategy.
	self
		assert:
			(strategy
				completionActionsFor: text asRopedText
				at: text size
				max: 10
				requested: true) notEmpty.
	^ strategy
]

{ #category : #smalltalk }
GtCompleterExamples >> completeInstanceVariableReceiver [
	<gtExample>
	| completer |
	completer := self completePrintOnMethodSelector.
	self
		enter:
			{Character cr.
			Character tab} , #('is' #tabComplete:)
		into: completer.
	self
		assert: completer textEditor text asString
		equals: self instanceVariableReceiverSource.
	^ completer
]

{ #category : #smalltalk }
GtCompleterExamples >> completeMultipleKeywordMessageSend [
	<gtExample>
	| completer |
	completer := self completeInstanceVariableReceiver.
	self
		enter:
			#(' prin')
				,
					{[ :controller | self selectPreviewMatching: 'print:on:' in: controller ].
					#tabComplete:}
				, #(#tabNext: 'va' #tabComplete: #tabNext: 'ma' #tabComplete:)
		into: completer.
	self
		assert: completer textEditor text asString
		equals:
			self instanceVariableReceiverSource
				, ' print: maxItems on: variableTypes'.
	self
		assert: (completer textEditor cursors allCursors collect: #position)
		equals: #(42).
	^ completer
]

{ #category : #smalltalk }
GtCompleterExamples >> completePrintOnMethodSelector [
	<gtExample>
	| completer |
	completer := self openOn: '' withStrategy: self smalltalkStrategy.
	self
		enter:
			#(0 'prin')
				,
					{[ :controller | self selectPreviewMatching: 'printOn:' in: controller ].
					#tabComplete:}
		into: completer.
	self
		assert: completer textEditor text asString
		equals: self printOnMethodSelectorSource.
	^ completer
]

{ #category : #completing }
GtCompleterExamples >> completeWithCursorMove [
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
GtCompleterExamples >> completeWithTab [
	<gtExample>
	| aCompleter |
	
	aCompleter := self openOn: '' withStrategy: self alphabetStrategy.
	self enter: #(0 'dd' #tabComplete:) into: aCompleter.
	
	self assert: aCompleter textEditor text asString equals: 'dddd'.
	self
		assert: (aCompleter textEditor cursors allCursors collect: #position)
		equals: #(4).
	self assert: aCompleter textEditor selection isEmpty.
	
	^ aCompleter
]

{ #category : #completing }
GtCompleterExamples >> completionPreview [
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

{ #category : #accessing }
GtCompleterExamples >> crLfMessageCompletion [
	<gtExample>
	| text strategy items |
	text := ('foo' , String crlf , '^3 ab') asRopedText.
	strategy := self smalltalkStrategy.
	items := strategy
		completionActionsFor: text
		at: 10
		max: 11
		requested: true.
	self assert: (items anySatisfy: [ :each | each label = 'abs' ]).
	^ strategy
]

{ #category : #private }
GtCompleterExamples >> editorElementFor: aString [
	| editor editorElement text |
	text := aString asRopedText.
	editor := BrTextEditor new.
	editor text: text.
	editorElement := BrEditorElement new.
	editorElement editor: editor.
	editorElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	^ editorElement
]

{ #category : #smalltalk }
GtCompleterExamples >> emptyExplicitlyRequestedCompletions [
	<gtExample>
	| text strategy index |
	text := '  "<"method:  "<"arg  "<"
		| var1 |
		var1  "<":= #().
		self inform: var1 size.
		^var1 size * 3'.
	strategy := self smalltalkStrategy.
	index := 1.
	[ (index := (text indexOfSubCollection: '"<"' startingAt: index) + 1)
		> 1 ]
		whileTrue: [ self
				assert:
					(strategy
						completionActionsFor: text asRopedText
						at: index - 2
						max: 10
						requested: true) isEmpty ].
	^ strategy
]

{ #category : #smalltalk }
GtCompleterExamples >> endingStatementRequestedCompletions [
	<gtExample>
	| text strategy index |
	text := 'method: arg 
		| var1 |
		var1  := #()  "<".
		self inform: var1 size  "<".
		^var1 size * 3  "<"'.
	strategy := self smalltalkStrategy.
	index := 1.
	[ (index := (text indexOfSubCollection: '"<"' startingAt: index) + 1)
		> 1 ]
		whileTrue: [ | actions |
			actions := strategy
				completionActionsFor: text asRopedText
				at: index - 2
				max: 10
				requested: true.
			self assert: actions notEmpty.
			self
				assert:
					(actions
						anySatisfy:
							[ :each | (each label includes: $:) or: [ each label asSymbol isBinary ] ]).
			self
				assert:
					(strategy
						completionActionsFor: text asRopedText
						at: index - 2
						max: 10
						requested: false) isEmpty ].
	^ strategy
]

{ #category : #private }
GtCompleterExamples >> enter: anArray into: completionController [
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
GtCompleterExamples >> insertString: aString on: completionController [

	"inserter deletes selected text by default"
	completionController textEditor inserter
		atCursor;
		string: aString;
		insert
]

{ #category : #'private-source' }
GtCompleterExamples >> instanceVariableReceiverSource [
	^ self printOnMethodSelectorSource
		,
			'
	isMethod'
]

{ #category : #smalltalk }
GtCompleterExamples >> methodSourceCompleter [
	<gtExample>
	| text styler editor editorElement completionStrategy completionController method ast |
	text := '' asRopedText.
	text attribute: (BlFontSizeAttribute size: 14) beNotOverwritableByStyler.
	method := OrderedCollection >> #addAll:.
	ast := GtPharoParser parse: method sourceCode.
	styler := BrRBMethodBodyTextStyler new.
	styler classOrMetaClass: method methodClass.
	styler methodPatternSource: ast pattern source.
	editor := BrTextEditor new.
	editor styler: styler.
	editor text: text.
	editorElement := BrEditorElement new.
	editorElement
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	editorElement editor: editor.
	completionStrategy := GtPharoCompletionStrategy new.
	completionStrategy classOrMetaClass: method methodClass.
	completionStrategy methodPattern: ast pattern.
	completionController := GtCompletionController on: editorElement strategy: completionStrategy.
	completionController install.
	^ editorElement
]

{ #category : #private }
GtCompleterExamples >> moveCursorTo: anInteger on: aCompletionController [
	self pauseForCompletion.
	aCompletionController textEditor moveCursorTo: anInteger
]

{ #category : #'examples - scripter' }
GtCompleterExamples >> move_cursor_to_end [
	<gtExample>
	| aScripter |
	
	aScripter := self request_focus.
	
	aScripter substep: 'Move cursor' do: [ :aStep |
		aStep keyClick: BlKeyboardKey arrowRight.
		aStep keyClick: BlKeyboardKey arrowRight ].
	
	^ aScripter syncContinue
]

{ #category : #private }
GtCompleterExamples >> openOn: aString withStrategy: aCompletionStrategy [
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
GtCompleterExamples >> pauseForCompletion [
	"advance time by popup delay (instantly)"
	space time wait: GtCompletionController popupDelay.
	"perform one more frame"
	space pulse
]

{ #category : #'private-source' }
GtCompleterExamples >> printOnMethodSelectorSource [
	^ 'printOn: aStream'
]

{ #category : #'examples - scripter' }
GtCompleterExamples >> remove_last_character_while_completion_is_about_to_appear [
	<gtExample>
	| aScripter |
	
	aScripter := self move_cursor_to_end.
	
	aScripter substep: 'Type e to start completion' do: [ :aStep |
		aStep
			type: 'e';
			onSelf ].
	
	aScripter
		substep: 'Wait for completion to appear'
		do: [ :aStep | aStep wait forEmptySpaceTaskQueue ].
		
	aScripter substep: 'Remove last character' do: [ :aStep |
		aStep keyClick: BlKeyboardKey backspace ].
	
	aScripter substep: 'Type e to start completion' do: [ :aStep |
		aStep
			type: 'e';
			onSelf ].

	aScripter substep: 'Remove last character' do: [ :aStep |
		aStep keyClick: BlKeyboardKey backspace ].
	
	^ aScripter syncContinue
]

{ #category : #'examples - scripter' }
GtCompleterExamples >> request_focus [
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
GtCompleterExamples >> scripter [
	<gtExample>
	
	^ BlDevScripter new
]

{ #category : #'instance creation' }
GtCompleterExamples >> scripterElement [
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
GtCompleterExamples >> scripterWithCompletion [
	<gtExample>
	| aScripter anEditor |
	
	aScripter := self scripter.
	anEditor := self scripterElement.
		
	aScripter element: anEditor.
	
	^ aScripter pulse
]

{ #category : #private }
GtCompleterExamples >> selectPreviewMatching: aString in: completionController [
	self pauseForCompletion.
	completionController completionActions isEmpty
		ifTrue: [ ^ self error: 'No completion actions' ].
	100
		timesRepeat: [ completionController
				selectedCompletionItemDo: [ :aCompletionItem | 
					(aString match: aCompletionItem label)
						ifTrue: [ ^ self ] ].
			completionController selectNextItem ].
	self error: 'Could not find completion action'
]

{ #category : #smalltalk }
GtCompleterExamples >> smalltalkCompleter [
	<gtExample>
	| text styler editor editorElement completionStrategy completionController |
	text := '' asRopedText.
	text
		attributes: { (BlFontSizeAttribute size: 14) beNotOverwritableByStyler }.
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
	completionStrategy := self smalltalkStrategy.
	completionController := GtCompletionController on: editorElement strategy: completionStrategy.
	completionController install.
	^ editorElement
]

{ #category : #strategies }
GtCompleterExamples >> smalltalkStrategy [
	<gtExample>
	| completionStrategy |
	completionStrategy := GtPharoCompletionStrategy newForMethod.
	completionStrategy classOrMetaClass: GtPharoCompletionStrategy.
	^ completionStrategy
]

{ #category : #smalltalk }
GtCompleterExamples >> startingStatementRequestedCompletions [
	<gtExample>
	| text strategy index |
	text := 'method: arg 
		| var1 |
		 "<"
		var1  := #().  "<"
		self inform: var1 size.  "<"
		^var1 size * 3'.
	strategy := self smalltalkStrategy.
	index := 1.
	[ (index := (text indexOfSubCollection: '"<"' startingAt: index) + 1)
		> 1 ]
		whileTrue: [ | actions |
			actions := strategy
				completionActionsFor: text asRopedText
				at: index - 2
				max: 10
				requested: true.
			self assert: actions notEmpty.
			self
				assert: (actions noneSatisfy: [ :each | each label includes: $: ]).
			self
				assert:
					(strategy
						completionActionsFor: text asRopedText
						at: index - 2
						max: 10
						requested: false) isEmpty ].
	^ strategy
]

{ #category : #private }
GtCompleterExamples >> tabComplete: completionController [
	self pauseForCompletion.
	completionController completeWithCursor: true
]

{ #category : #private }
GtCompleterExamples >> tabNext: completionController [
	completionController processTabKey: true
]
