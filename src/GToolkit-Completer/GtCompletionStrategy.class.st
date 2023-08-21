Class {
	#name : #GtCompletionStrategy,
	#superclass : #Object,
	#category : #'GToolkit-Completer-Strategies'
}

{ #category : #accessing }
GtCompletionStrategy class >> matchingCharacterAttributes [
	^ {BlTextDecorationAttribute new
			color: BrGlamorousColors textHighlightColor;
			thickness: 3;
			underline}
]

{ #category : #completing }
GtCompletionStrategy >> completionPrefixAt: anIndex in: blText [
	| startIndex |
	anIndex < self minimumPrefixLength
		ifTrue: [ ^ nil ].
	startIndex := anIndex.
	[ (self isSeparatorCharacter: (blText at: startIndex))
		ifTrue: [ ^ anIndex - startIndex < self minimumPrefixLength
				ifTrue: [ nil ]
				ifFalse: [ (blText copyFrom: startIndex + 1 to: anIndex) asString ] ].
	startIndex := startIndex - 1.
	startIndex >= 1 ] whileTrue.
	^ (blText copyFrom: 1 to: anIndex) asString
]

{ #category : #completing }
GtCompletionStrategy >> completionResultFor: aText at: positionInteger requested: aBoolean [
	"Given a text or a string, and a position within that text, attempt to find suitable completions grouped in a completion result. A completion strategy may return an empty completion result if it decides that there is no need to offer them, for example when completing an empty text or when the text matches a completion item. By passing `requested: true` users can force a completion strategy to provide completion results anyway."

	^ GtCompletionResult empty
]

{ #category : #testing }
GtCompletionStrategy >> hasCompletionEntryFor: aString [
	^ true
]

{ #category : #testing }
GtCompletionStrategy >> hasCompletionsAt: anInteger in: aText [
	| prefix |
	prefix := self completionPrefixAt: anInteger in: aText.
	prefix isNil
		ifTrue: [ ^ false ].
	^ self hasCompletionEntryFor: prefix
]

{ #category : #testing }
GtCompletionStrategy >> isSeparatorCharacter: aCharacter [
	^ aCharacter isSeparator
]

{ #category : #testing }
GtCompletionStrategy >> isSubsequence: subString of: completeString [
	^ (self subsequenceIndices: subString of: completeString) size = subString size
]

{ #category : #private }
GtCompletionStrategy >> labelFor: aString withSearch: subString [
	| text attributes |
	attributes := self class matchingCharacterAttributes.
	text := aString asRopedText glamorousCodeFont.
	(self subsequenceIndices: subString of: aString)
		do: [ :i | (text from: i to: i) attributes: attributes ].
	^ text
]

{ #category : #private }
GtCompletionStrategy >> labelFor: aString withWords: wordString [
	| text attributes |
	attributes := {BlTextDecorationAttribute new
				color: BrGlamorousColors textHighlightColor;
				thickness: 3;
				underline}.
	text := aString asRopedText glamorousCodeFont.
	(aString beginsWith: wordString caseSensitive: false)
		ifTrue: [ (text from: 1 to: wordString size) attributes: attributes ]
		ifFalse: [ (GtPharoIndex current intervalsIn: aString matching: wordString)
				ifEmpty: [ (self subsequenceIndices: wordString of: aString)
						do: [ :i | (text from: i to: i) attributes: attributes ] ]
				ifNotEmpty: [ :col | col do: [ :each | (text from: each first to: each last) attributes: attributes ] ] ].
	^ text
]

{ #category : #accessing }
GtCompletionStrategy >> minimumPrefixLength [
	"Minimum length of the prefix before the completion popup appears"

	^ 1
]

{ #category : #private }
GtCompletionStrategy >> subsequenceIndices: subString of: completeString [
	| i results |
	subString size > completeString size ifTrue: [ ^ #() ].
	results := OrderedCollection new: subString size.
	i := 0.
	subString
		do: [ :char | 
			i := completeString indexOf: char startingAt: i + 1.
			i > 0 ifTrue: [ results add: i ] ifFalse: [ ^ #() ] ].
	^ results
]
