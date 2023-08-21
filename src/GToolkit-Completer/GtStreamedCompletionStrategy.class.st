Class {
	#name : #GtStreamedCompletionStrategy,
	#superclass : #GtCompletionStrategy,
	#category : #'GToolkit-Completer-Strategies'
}

{ #category : #completing }
GtStreamedCompletionStrategy >> completionActionStreamFor: aText at: positionInteger requested: isRequested [
	| prefix |
	
	prefix := self completionPrefixAt: positionInteger in: aText.

	isRequested
		ifFalse: [ (prefix isNil
				or: [ prefix size < self minimumPrefixLength
						or: [ (self hasCompletionEntryFor: prefix) not ] ])
				ifTrue: [ ^ #() asAsyncStream ] ].

	prefix := prefix ifNil: [ '' ].

	^ (self completionStringStreamStartingWith: prefix)
		collect: [ :each | 
			GtInsertTextCompletionAction
				labeled: (self labelFor: each withSearch: prefix)
				completion: (each allButFirst: prefix size)
				position: positionInteger ]
]

{ #category : #completing }
GtStreamedCompletionStrategy >> completionResultFor: aText at: positionInteger requested: isRequested [
	^ GtStreamedCompletionResult
		onStream:
			(self
				completionActionStreamFor: aText
				at: positionInteger
				requested: isRequested)
]

{ #category : #completing }
GtStreamedCompletionStrategy >> completionStringStreamStartingWith: aPrefixString [
	"Please note, that a prefix string can be empty"

	^ #() asAsyncStream
]
