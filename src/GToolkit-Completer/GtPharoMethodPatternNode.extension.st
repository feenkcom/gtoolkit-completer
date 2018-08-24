Extension { #name : #GtPharoMethodPatternNode }

{ #category : #'*GToolkit-Completer' }
GtPharoMethodPatternNode >> completionActionsFor: aStrategy [
	| seen prefix actions |
	(self selectorParts size = 1 and: [ self selectorParts first stopPosition = aStrategy index ])
		ifFalse: [ ^ #() ].
	prefix := self selectorParts first source.
	seen := Set new.
	actions := OrderedCollection new.
	(aStrategy hierarchyMethodsStartingWith: prefix)
		do: [ :each | 
			((seen includes: each selector)
				or: [ aStrategy classOrMetaClass includesSelector: each selector ])
				ifFalse: [ seen add: each selector.
					actions
						add:
							(GtInsertTextCompletionAction
								labeled: each selector
								completion: ((aStrategy signatureFor: each) allButFirst: prefix size)
								position: aStrategy index
								from: aStrategy index - prefix size + 1).
					actions size = aStrategy maxItems
						ifTrue: [ ^ actions ] ] ].
	^ actions
]
