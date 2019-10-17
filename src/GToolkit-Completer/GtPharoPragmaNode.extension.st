Extension { #name : #GtPharoPragmaNode }

{ #category : #'*GToolkit-Completer' }
GtPharoPragmaNode >> completionActionsFor: aStrategy [
	| prefix pragmas index |
	index := aStrategy index.
	(self lessThan stopPosition = index
		and: [ self selectorParts isEmpty ])
		ifTrue: [ prefix := '' ].
	(self selectorParts size = 1
		and: [ self selectorParts first stopPosition = index ])
		ifTrue: [ prefix := self selectorParts first source ].
	prefix isNil
		ifTrue: [ ^ #() ].
	pragmas := aStrategy pragmas: aStrategy maxItems startingWith: prefix.
	^ pragmas
		collect: [ :each | 
			self
				actionForSelector: each
				startingWith: prefix
				at: index
				needsParensKeywords: false ]
]
