Class {
	#name : #BrTextEditorEmptyCompletionStrategy,
	#superclass : #BrTextEditorCompletionStrategy,
	#category : #'GToolkit-Completer-Strategies'
}

{ #category : #completing }
BrTextEditorEmptyCompletionStrategy >> completionPrefixAt: anIndex in: aString [
	<return: #String or: nil>
	^ nil
]

{ #category : #completing }
BrTextEditorEmptyCompletionStrategy >> completionResultFor: aText at: positionInteger requested: aBoolean [
	<return: #GtCompletionResult>
	^ GtCompletionResult empty
]
