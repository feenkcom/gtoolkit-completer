Class {
	#name : #BrTextEditorCompletionStrategy,
	#superclass : #Object,
	#category : #'GToolkit-Completer-Strategies'
}

{ #category : #'instance creation' }
BrTextEditorCompletionStrategy class >> empty [
	^ BrTextEditorEmptyCompletionStrategy new
]

{ #category : #completing }
BrTextEditorCompletionStrategy >> completionPrefixAt: anIndex in: aString [
	<return: #String or: nil>
	^ self subclassResponsibility
]

{ #category : #completing }
BrTextEditorCompletionStrategy >> completionResultFor: aText at: positionInteger requested: aBoolean [
	"Given a text or a string, and a position within that text, attempt to find suitable completions grouped in a completion result. A completion strategy may return an empty completion result if it decides that there is no need to offer them, for example when completing an empty text or when the text matches a completion item. By passing `requested: true` users can force a completion strategy to provide completion results anyway."

	<return: #GtCompletionResult>
	^ self subclassResponsibility
]
