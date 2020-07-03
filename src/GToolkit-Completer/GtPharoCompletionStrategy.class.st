Class {
	#name : #GtPharoCompletionStrategy,
	#superclass : #GtCompletionStrategy,
	#instVars : [
		'class',
		'isMethod',
		'wasRequested',
		'hasImplicitVariables',
		'methodPattern',
		'variables',
		'localVariables',
		'index',
		'maxItems',
		'pragmas',
		'variableTypes',
		'bindings'
	],
	#classVars : [
		'GlobalCache',
		'SelectorCache'
	],
	#category : #'GToolkit-Completer-Pharo'
}

{ #category : #private }
GtPharoCompletionStrategy class >> classAdded: anAnnouncement [
	GlobalCache add: anAnnouncement classAdded name
]

{ #category : #private }
GtPharoCompletionStrategy class >> classRemoved: anAnnouncement [
	GlobalCache
		remove:
			(anAnnouncement classRemoved name
				copyReplaceAll: 'AnObsolete'
				with: '')
]

{ #category : #private }
GtPharoCompletionStrategy class >> classRenamed: anAnnouncement [
	GlobalCache
		remove: anAnnouncement oldName;
		add: anAnnouncement newName
]

{ #category : #'class initialization' }
GtPharoCompletionStrategy class >> initialize [
	SelectorCache := GtPrefixTree new.
	Smalltalk
		allClassesDo: [ :each | 
			SelectorCache
				addAll: each selectors;
				addAll: each class selectors ].
	Smalltalk allTraits
		do: [ :each | SelectorCache addAll: each selectors ].
	GlobalCache := GtPrefixTree withAll: Smalltalk globals keys.
	self subscribeToSystem
]

{ #category : #private }
GtPharoCompletionStrategy class >> methodAdded: anAnnouncement [
	SelectorCache add: anAnnouncement method selector
]

{ #category : #private }
GtPharoCompletionStrategy class >> methodRemoved: anAnnouncement [
	SelectorCache remove: anAnnouncement method selector
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
GtPharoCompletionStrategy class >> subscribeToSystem [
	SystemAnnouncer uniqueInstance weak
		when: MethodAdded send: #methodAdded: to: self;
		when: MethodRemoved send: #methodRemoved: to: self;
		when: ClassAdded send: #classAdded: to: self;
		when: ClassRemoved send: #classRemoved: to: self;
		when: ClassRenamed send: #classRenamed: to: self
]

{ #category : #private }
GtPharoCompletionStrategy class >> unsubscribeFromSystem [
	SystemAnnouncer uniqueInstance unsubscribe: self
]

{ #category : #accessing }
GtPharoCompletionStrategy >> bindings [
	^ bindings
]

{ #category : #accessing }
GtPharoCompletionStrategy >> bindings: anObject [
	bindings := anObject
]

{ #category : #accessing }
GtPharoCompletionStrategy >> blockVariables: aDictionary [
	variableTypes := Dictionary new.
	aDictionary
		keysAndValuesDo: [ :name :cls | 
			localVariables add: name.
			variableTypes at: name put: cls ].
	self isMethod: false
]

{ #category : #accessing }
GtPharoCompletionStrategy >> classOrMetaClass [
	^ class
]

{ #category : #accessing }
GtPharoCompletionStrategy >> classOrMetaClass: aClass [
	class := aClass.
	class notNil
		ifTrue: [ localVariables addAll: class allInstVarNames.
			class isMeta
				ifTrue: [ localVariables addAll: class instanceSide allClassVarNames ]
				ifFalse: [ localVariables addAll: class allClassVarNames ].
			class superclass notNil
				ifTrue: [ localVariables add: 'super' ] ]
]

{ #category : #accessing }
GtPharoCompletionStrategy >> completionActionsFor: aText at: positionInteger max: maxInteger requested: aBoolean [
	maxItems := maxInteger.
	index := positionInteger.
	wasRequested := aBoolean.
	^ (self parseSource: aText characters asString)
		ifNil: [ #() ]
		ifNotNil: [ :tree | tree completionActionsFor: self ]
]

{ #category : #accessing }
GtPharoCompletionStrategy >> forMethod: aCompiledMethod [
	| source ast |
	self classOrMetaClass: aCompiledMethod methodClass.
	source := aCompiledMethod sourceCode.
	ast := GtPharoParser parse: source.
	self methodPattern: ast pattern
]

{ #category : #ui }
GtPharoCompletionStrategy >> gtItemsFor: aView [
	<gtView>
	^ self variables 
		ifNil:  [ ^ aView ]
		ifNotNil: [ self variables gtItemsFor: aView ]
]

{ #category : #ui }
GtPharoCompletionStrategy >> gtViewChildrenFor: aView [
	<gtView>
	^ self variables 
		ifNil:  [ ^ aView empty ]
		ifNotNil: [ self variables gtItemsFor: aView ]
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
	localVariables := GtPrefixTree
		withAll: #('self' 'true' 'false' 'nil' 'thisContext').
	variables := GtCompositePrefixTree
		trees:
			{GlobalCache.
			localVariables}
]

{ #category : #'initialize-release' }
GtPharoCompletionStrategy >> isMethod: aBoolean [
	isMethod := aBoolean
]

{ #category : #'private-variables' }
GtPharoCompletionStrategy >> localVariablesFor: aVariableNode [
	^ self hasImplicitVariables
		ifTrue: [ aVariableNode implicitLocalVariables ]
		ifFalse: [ aVariableNode localVariables ]
]

{ #category : #accessing }
GtPharoCompletionStrategy >> maxItems [
	^ maxItems
]

{ #category : #accessing }
GtPharoCompletionStrategy >> methodPattern: aMethodPattern [
	methodPattern := aMethodPattern.
	methodPattern notNil
		ifTrue: [ methodPattern variables
				do: [ :each | localVariables add: each name value ] ].
	self isMethod: false
]

{ #category : #private }
GtPharoCompletionStrategy >> parseSource: aString [
	^ [ isMethod
		ifTrue: [ GtPharoParser parseWithErrors: aString ]
		ifFalse: [ GtPharoParser parseWithErrors: aString startingAt: GtPharoParser startingStateForMethodSequence ] ]
		on: SmaCCParserError
		do: [ :ex | ex return: nil ]
]

{ #category : #'private-pragmas' }
GtPharoCompletionStrategy >> pragmas [
	pragmas isNil
		ifTrue: [ pragmas := GtPrefixTree new.
			Smalltalk image
				allClassesAndTraitsDo: [ :each | 
					[ :cls | cls selectors do: [ :sel | (cls >> sel) pragmas do: [ :pragma | pragmas add: pragma selector ] ] ]
						value: each;
						value: each class ] ].
	^ pragmas
]

{ #category : #'private-pragmas' }
GtPharoCompletionStrategy >> pragmas: anInteger startingWith: aString [
	^ self pragmas weightedFirst: anInteger startingWith: aString
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

{ #category : #typing }
GtPharoCompletionStrategy >> typeOfVariable: aString [
	aString = 'self'
		ifTrue: [ ^ self classOrMetaClass ].
	aString = 'super'
		ifTrue: [ ^ self classOrMetaClass superclass ].
	self classOrMetaClass notNil
		ifTrue: [ (self classOrMetaClass bindingOf: aString asSymbol) ifNotNil: [ :binding | ^ binding value class ] ].
	bindings notNil
		ifTrue: [ (bindings bindingOf: aString asSymbol) ifNotNil: [ :binding | ^ binding value class ] ].
	variableTypes notNil
		ifTrue: [ (variableTypes at: aString ifAbsent: [ nil ]) ifNotNil: [ :cls | ^ cls ] ].
	^ nil
]

{ #category : #private }
GtPharoCompletionStrategy >> variableCompletionActionsFor: anAST [
	| vars allLocalVariables |
	allLocalVariables := self localVariablesFor: anAST.
	vars := allLocalVariables first: self maxItems startingWith: ''.
	vars
		addAll: (self variables first: self maxItems - vars size startingWith: '').
	^ vars
		collect: [ :each | 
			GtInsertTextCompletionAction
				labeled: each
				completion: each
				position: self index ]
]

{ #category : #accessing }
GtPharoCompletionStrategy >> variables [
	^ variables
]

{ #category : #testing }
GtPharoCompletionStrategy >> wasRequested [
	^ wasRequested
]
