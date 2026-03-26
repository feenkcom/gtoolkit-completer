Extension { #name : #BrEditorElement }

{ #category : #'*GToolkit-Completer' }
BrEditorElement >> completionStrategy: aGtCompletionStrategy [
	self userData
		at: GtCompletionController
		ifPresent: [ :aController | aController strategy: aGtCompletionStrategy ]
		ifAbsentPut: [ | aCompleter |
			aCompleter := GtCompletionController on: self.
			aCompleter
				strategy: aGtCompletionStrategy;
				install ]
]
