Class {
	#name : #GtStreamedCompletionStrategy,
	#superclass : #GtCompletionStrategy,
	#category : #'GToolkit-Completer-Strategies'
}

{ #category : #completing }
GtStreamedCompletionStrategy >> completionActionStreamFor: aText at: positionInteger [
	| prefix |
	prefix := self completionPrefixAt: positionInteger in: aText.
	(prefix isNil or: [ prefix size < self minimumPrefixLength or: [ (self hasCompletionEntryFor: prefix) not ] ])
		ifTrue: [ ^ #() asAsyncStream ].
	^ (self completionStringStreamStartingWith: prefix)
		collect:
			[ :each | 
			GtInsertTextCompletionAction
				labeled: (self labelFor: each withSearch: prefix)
				completion: (each allButFirst: prefix size)
				position: positionInteger ]
]

{ #category : #completing }
GtStreamedCompletionStrategy >> completionActionStreamFor: aText at: positionInteger requested: aBoolean [
	^ self completionActionStreamFor: aText at: positionInteger
]

{ #category : #completing }
GtStreamedCompletionStrategy >> completionResultFor: aText at: positionInteger requested: aBoolean [
	^ GtStreamedCompletionResult
		onStream:
			(self
				completionActionStreamFor: aText
				at: positionInteger
				requested: aBoolean)
]

{ #category : #completing }
GtStreamedCompletionStrategy >> completionStringStreamStartingWith: aString [
	^ #() asAsyncStream
]
