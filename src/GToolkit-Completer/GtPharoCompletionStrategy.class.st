Class {
	#name : #GtPharoCompletionStrategy,
	#superclass : #GtCompletionStrategy,
	#instVars : [
		'class',
		'isMethod',
		'hasImplicitVariables',
		'methodPattern',
		'variables',
		'index',
		'maxItems'
	],
	#classVars : [
		'SelectorCache'
	],
	#category : 'GToolkit-Completer-Pharo'
}

{ #category : #'class initialization' }
GtPharoCompletionStrategy class >> initialize [
	SelectorCache := GtPrefixTree new.
	Smalltalk
		allClassesDo: [ :each | 
			SelectorCache
				addAll: each selectors;
				addAll: each class selectors ].
	Smalltalk allTraits do: [ :each | SelectorCache addAll: each selectors ]
]

{ #category : #'instance creation' }
GtPharoCompletionStrategy class >> newForExpression [
	^ self new
		isMethod: false;
		yourself
]

{ #category : #'instance creation' }
GtPharoCompletionStrategy class >> newForMethod [
	^ self new
		isMethod: true;
		yourself
]

{ #category : #'instance creation' }
GtPharoCompletionStrategy class >> newForSnippet [
	^ self new
		isMethod: false;
		hasImplicitVariables: true;
		yourself
]

{ #category : #private }
GtPharoCompletionStrategy >> actionsFor: anAST at: anInteger [
	^ (self nodeFor: anInteger in: anAST) ifNil: [ #() ] ifNotNil: [ :node | node completionActionsFor: self ]
]

{ #category : #accessing }
GtPharoCompletionStrategy >> classOrMetaClass [
	^ class
]

{ #category : #accessing }
GtPharoCompletionStrategy >> classOrMetaClass: aClass [
	class := aClass.
	class notNil
		ifTrue: [ variables addAll: class allInstVarNames.
			class isMeta
				ifTrue: [ variables addAll: class instanceSide allClassVarNames ]
				ifFalse: [ variables addAll: class allClassVarNames ].
			class superclass notNil
				ifTrue: [ variables add: 'super' ] ]
]

{ #category : #accessing }
GtPharoCompletionStrategy >> completionActionsFor: aText at: positionInteger max: maxInteger [
	maxItems := maxInteger.
	index := positionInteger.
	^ (self parseSource: aText asString) ifNil: [ #() ] ifNotNil: [ :tree | self actionsFor: tree at: positionInteger ]
]

{ #category : #accessing }
GtPharoCompletionStrategy >> forMethod: aCompiledMethod [
	| source ast |
	self classOrMetaClass: aCompiledMethod methodClass.
	source := aCompiledMethod sourceCode.
	ast := GtPharoParser parse: source.
	self methodPattern: ast pattern
]

{ #category : #testing }
GtPharoCompletionStrategy >> hasCompletionsAt: anInteger in: aText [
	| char |
	anInteger < 1
		ifTrue: [ ^ false ].
	char := aText at: anInteger.
	^ char isLetter or: [ char isDigit ]
]

{ #category : #accessing }
GtPharoCompletionStrategy >> hasImplicitVariables [
	^ hasImplicitVariables
]

{ #category : #accessing }
GtPharoCompletionStrategy >> hasImplicitVariables: aBoolean [
	hasImplicitVariables := aBoolean
]

{ #category : #'private-method' }
GtPharoCompletionStrategy >> hierarchyMethodsStartingWith: aString [
	| methods |
	class isNil
		ifTrue: [ ^ #() ].
	methods := OrderedCollection new.
	class
		allSuperclassesDo: [ :each | methods addAll: ((each selectors select: [ :sel | sel beginsWith: aString ]) asSortedCollection collect: [ :sel | each >> sel ]) ].
	class
		allSubclassesDo: [ :each | methods addAll: ((each selectors select: [ :sel | sel beginsWith: aString ]) asSortedCollection collect: [ :sel | each >> sel ]) ].
	^ methods
]

{ #category : #accessing }
GtPharoCompletionStrategy >> index [
	^ index
]

{ #category : #'initialize-release' }
GtPharoCompletionStrategy >> initialize [
	super initialize.
	isMethod := true.
	hasImplicitVariables := false.
	variables := GtPrefixTree withAll: Smalltalk globals keys.
	variables addAll: #('self' 'true' 'false' 'nil' 'thisContext')
]

{ #category : #'initialize-release' }
GtPharoCompletionStrategy >> isMethod: aBoolean [
	isMethod := aBoolean
]

{ #category : #accessing }
GtPharoCompletionStrategy >> maxItems [
	^ maxItems
]

{ #category : #accessing }
GtPharoCompletionStrategy >> methodPattern: aMethodPattern [
	methodPattern := aMethodPattern.
	methodPattern notNil
		ifTrue: [ methodPattern variables do: [ :each | variables add: each name value ] ].
	self isMethod: false
]

{ #category : #private }
GtPharoCompletionStrategy >> nodeFor: anInteger in: anAST [
	| node |
	anAST
		withAllNodesDo: [ :each | 
			(anInteger between: each startPosition and: each stopPosition)
				ifTrue: [ node := each ] ].
	^ node
]

{ #category : #private }
GtPharoCompletionStrategy >> parseSource: aString [
	^ [ isMethod
		ifTrue: [ GtPharoParser parseWithErrors: aString ]
		ifFalse: [ GtPharoParser parseWithErrors: aString startingAt: GtPharoParser startingStateForMethodSequence ] ]
		on: SmaCCParserError
		do: [ :ex | ex return: nil ]
]

{ #category : #'private-selector' }
GtPharoCompletionStrategy >> selectorsForReceiver: aBehavior matching: aString [
	| tree |
	tree := aBehavior notNil
		ifTrue: [ GtPrefixTree withAll: aBehavior allSelectors ]
		ifFalse: [ SelectorCache ].
	^ tree weightedFirst: maxItems startingWith: aString
]

{ #category : #'private-method' }
GtPharoCompletionStrategy >> signatureFor: aMethod [
	| source ast |
	source := aMethod sourceCode.
	ast := GtPharoParser parse: source.
	^ source
		copyFrom: ast selectorParts first startPosition
		to:
			(ast variables isEmpty
				ifTrue: [ ast selectorParts ]
				ifFalse: [ ast variables ]) last stopPosition
]

{ #category : #accessing }
GtPharoCompletionStrategy >> variables [
	^ variables
]
