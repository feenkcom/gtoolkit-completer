Class {
	#name : #GtCompletionStrategy,
	#superclass : #Object,
	#category : #'GToolkit-Completer'
}

{ #category : #accessing }
GtCompletionStrategy >> completionActionsFor: aText at: positionInteger max: maxSize [
	| prefix |
	prefix := self completionPrefixAt: positionInteger in: aText.
	(prefix isNil or: [ prefix size < self minimumPrefixLength ])
		ifTrue: [ ^ #() ].
	(self hasCompletionEntryFor: prefix)
		ifFalse: [ ^ #() ].
	^ (self first: maxSize startingWith: prefix)
		collect:
			[ :each | GtInsertTextCompletionAction labeled: each completion: (each allButFirst: prefix size) position: positionInteger ]
]

{ #category : #accessing }
GtCompletionStrategy >> completionActionsFor: aText at: positionInteger max: maxSize requested: aBoolean [
	^ self completionActionsFor: aText at: positionInteger max: maxSize
]

{ #category : #accessing }
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

{ #category : #accessing }
GtCompletionStrategy >> first: anInteger startingWith: aString [
	^ #()
]

{ #category : #testing }
GtCompletionStrategy >> hasCompletionEntryFor: aString [
	^ false
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

{ #category : #accessing }
GtCompletionStrategy >> minimumPrefixLength [
	"Minimum length of the prefix before the completion popup appears"

	^ 1
]
