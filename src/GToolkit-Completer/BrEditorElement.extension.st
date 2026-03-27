Extension { #name : #BrEditorElement }

{ #category : #'*GToolkit-Completer' }
BrEditorElement >> completionStrategy: aCompletionStrategy [
	self assert: [ aCompletionStrategy isNotNil ].

	self userData
		at: GtCompletionController
		ifPresent: [ :aController | 
			aController strategy: aCompletionStrategy.
			aController isInstalled ifFalse: [ aController install ] ]
		ifAbsentPut: [ | aController |
			aController := GtCompletionController on: self.
			aController
				strategy: aCompletionStrategy;
				install.
			aController ]
]

{ #category : #'*GToolkit-Completer' }
BrEditorElement >> resetCompletionStrategy [
	self userData
		at: GtCompletionController
		ifPresent: [ :aController | aController uninstall ]
		ifAbsent: [ "ignore" ]
]
