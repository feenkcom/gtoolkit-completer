Class {
	#name : #GtCompleterExamples,
	#superclass : #Object,
	#category : 'GToolkit-Completer-Examples'
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

{ #category : #private }
GtCompleterExamples >> cmdLeftOn: completionController [
	self pauseForCompletion.
	completionController
		processKeyDown:
			(BlKeyDownEvent new
				key: Key arrowLeft;
				modifiers:
					(BlKeyModifiers
						shift: false
						ctrl: false
						alt: false
						cmd: true);
				yourself)
]

{ #category : #private }
GtCompleterExamples >> cmdRightOn: completionController [
	self pauseForCompletion.
	completionController
		processKeyDown:
			(BlKeyDownEvent new
				key: Key arrowRight;
				modifiers:
					(BlKeyModifiers
						shift: false
						ctrl: false
						alt: false
						cmd: true);
				yourself)
]

{ #category : #completing }
GtCompleterExamples >> completeWithCursorMove [
	<gtExample>
	| aCompleter |

	aCompleter := self openOn: '12345' withStrategy: self alphabetStrategy entering: #(0 $b 4).

	self assert: aCompleter textEditor text asString equals: 'b12345'.
	self assert: aCompleter textEditor cursor position equals: 4.
	self assert: aCompleter textEditor selection isEmpty.

	^ aCompleter
]

{ #category : #completing }
GtCompleterExamples >> completeWithTab [
	<gtExample>
	| aCompleter |
	
	aCompleter := self openOn: '' withStrategy: self alphabetStrategy entering: #(0 'dd' #tabOn:).

	self assert: aCompleter textEditor text asString equals: 'dd'.
	self assert: aCompleter textEditor cursor position equals: 2.
	self assert: aCompleter textEditor selection isEmpty.

	^ aCompleter
]

{ #category : #completing }
GtCompleterExamples >> completionPreview [
	<gtExample>
	| aCompleter |
	
	aCompleter := self openOn: '' withStrategy: self alphabetStrategy entering: #(0 $c).

	self assert: aCompleter textEditor text asString equals: 'c'.
	self assert: aCompleter textEditor cursor position equals: 1.
	self assert: aCompleter textEditor selection isEmpty.

	^ aCompleter
]

{ #category : #private }
GtCompleterExamples >> deleteSelectedTextOn: completionController [

	completionController textEditor deleter
		selected;
		delete
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
				ifTrue: [ each value: completionController ] ]
]

{ #category : #private }
GtCompleterExamples >> escapeOn: completionController [
	self pauseForCompletion.
	completionController
		processKeyDown:
			(BlKeyDownEvent new
				key: Key escape;
				modifiers:
					(BlKeyModifiers
						shift: false
						ctrl: false
						alt: false
						cmd: false);
				yourself)
]

{ #category : #private }
GtCompleterExamples >> insertString: aString on: completionController [

	"inserter deletes selected text by default"
	completionController textEditor inserter
		atCursor;
		string: aString;
		insert
]

{ #category : #smalltalk }
GtCompleterExamples >> methodSourceCompleter [
	<gtExample>
	| text styler editor editorElement completionStrategy completionController method ast |
	text := '' asRopedText.
	text
		attributes:
			{BrFontGenericFamilyAttribute monospace beNotOverwritableByStyler.
			(BrFontSizeAttribute size: 14) beNotOverwritableByStyler}.
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

{ #category : #private }
GtCompleterExamples >> openOn: aString withStrategy: aCompletionStrategy entering: anArray [
	| editorElement completionController aSpace |
	
	editorElement := self editorElementFor: aString.
	"editor must have focus for cursor to appear"
	editorElement requestFocus.

	completionController := GtCompletionController on: editorElement strategy: aCompletionStrategy.
	completionController install.

	aSpace := BlSpace new.
	"simulated time allows us to instantly advance space time by a given duration without using forks"
	aSpace time: BlTime simulated.
	aSpace addChild: editorElement.

	self enter: anArray into: completionController.
	"we manually ask the space to step one frame"
	aSpace pulse.

	"advance time by popup delay (instantly)"
	aSpace time wait: GtCompletionController popupDelay.
	"perform one more frame"
	aSpace pulse.

	^ completionController
]

{ #category : #private }
GtCompleterExamples >> pauseForCompletion [
	| semaphore |
	semaphore := Semaphore new.
	[ (Delay forMilliseconds: 50) wait.
	semaphore signal ] fork.
	semaphore wait
]

{ #category : #private }
GtCompleterExamples >> selectPreviewMatching: aString in: completionController [
	self pauseForCompletion.
	completionController completionActions isEmpty
		ifTrue: [ ^ self ].
	100
		timesRepeat: [		
			completionController selectedCompletionItemDo: [ :aCompletionItem |
				(aString match: aCompletionItem label)
					ifTrue: [ ^ self ] ].
			completionController selectNextItem ]
]

{ #category : #smalltalk }
GtCompleterExamples >> smalltalkCompleter [
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
	completionStrategy := self smalltalkStrategy.
	completionController := GtCompletionController on: editorElement strategy: completionStrategy.
	completionController install.
	^ editorElement
]

{ #category : #smalltalk }
GtCompleterExamples >> smalltalkCompletion [
	<gtExample>
	^ self
		openOn: ''
		withStrategy: self smalltalkStrategy
		entering:
			#(0 'prin')
				,
					{[ :controller | self selectPreviewMatching: 'printOn:' in: controller ].
					#tabOn:.
					Character cr.
					Character tab} , #('is' #tabOn: $  'pr')
				,
					{[ :controller | self selectPreviewMatching: 'print:on:' in: controller ].
					#tabOn:} , #('ma' #tabOn: #tabOn: 'va' #tabOn:)

"printOn: aStream
	isMethod print: maxItems on: variables"
]

{ #category : #strategies }
GtCompleterExamples >> smalltalkStrategy [
	<gtExample>
	| completionStrategy |
	completionStrategy := GtPharoCompletionStrategy newForMethod.
	completionStrategy classOrMetaClass: GtPharoCompletionStrategy.
	^ completionStrategy
]

{ #category : #private }
GtCompleterExamples >> tabOn: completionController [
	self pauseForCompletion.
	completionController
		processKeystroke:
			(BlKeystrokeEvent new
				char: Character tab;
				yourself)
]
