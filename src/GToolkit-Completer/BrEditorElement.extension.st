Extension { #name : #BrEditorElement }

{ #category : #'*GToolkit-Completer' }
BrEditorElement >> completionControllerClass: aCompletionControllerClass [
	self
		deprecated: 'Use just #completionStrategy: instead. 
It is not possible to set completion controller in the new editor element,
therefore such settings will not be supported.'.

	self userData
		at: GtCompletionController
		ifPresent: [ :aController | 
			aController uninstall.
			aController userData removeKey: GtCompletionController ifAbsent: [  ] ].

	self userData at: #completionControllerClass put: aCompletionControllerClass
]

{ #category : #'*GToolkit-Completer' }
BrEditorElement >> completionStrategy: aCompletionStrategy [
	self assert: [ aCompletionStrategy isNotNil ].

	self userData
		at: GtCompletionController
		ifPresent: [ :aController | 
			aController strategy: aCompletionStrategy.
			aController isInstalled ifFalse: [ aController install ] ]
		ifAbsentPut: [ | aControllerClass aController |
			aControllerClass := self userData
					at: #completionControllerClass
					ifAbsent: [ GtCompletionController ].
			aController := aControllerClass on: self.
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
