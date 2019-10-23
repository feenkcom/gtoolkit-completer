Extension { #name : #GtPharoMethodSequenceNode }

{ #category : #'*GToolkit-Completer' }
GtPharoMethodSequenceNode >> completionActionsFor: aStrategy [
	pragmas
		do: [ :each | 
			(aStrategy index between: each startPosition and: each stopPosition)
				ifTrue: [ ^ each completionActionsFor: aStrategy ] ].
	^ super completionActionsFor: aStrategy
]
