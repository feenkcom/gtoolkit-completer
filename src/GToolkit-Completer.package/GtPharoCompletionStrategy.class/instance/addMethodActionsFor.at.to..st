private-method
addMethodActionsFor: methodNode at: anInteger to: actions
	| seen prefix |
	methodNode selectorParts size = 1
		ifFalse: [ ^ self ].
	methodNode selectorParts first stopPosition = anInteger
		ifFalse: [ ^ self ].
	prefix := methodNode selectorParts first source.
	seen := Set new.
	(self hierarchyMethodsStartingWith: prefix)
		do: [ :each | 
			((seen includes: each selector) or: [ class includesSelector: each selector ])
				ifFalse: [ seen add: each selector.
					actions
						add: (GtInsertTextCompletionAction labeled: each selector completion: ((self signatureFor: each) allButFirst: prefix size) position: anInteger).
					actions size = max
						ifTrue: [ ^ self ] ] ]