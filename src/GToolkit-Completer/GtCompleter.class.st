Class {
	#name : 'GtCompleter',
	#superclass : 'Object',
	#instVars : [
		'defaultStrategy',
		'maxPopupItems',
		'showRequested'
	],
	#category : 'GToolkit-Completer-Model'
}

{ #category : 'accessing' }
GtCompleter >> complete: aBlText at: anIndex [
	"Given a text and an index, compute and return a collection of applicable completion actions"

	^ (self strategyAt: anIndex in: aBlText)
		completionActionsFor: aBlText
		at: anIndex
		max: self maxCompletionItems
		requested: showRequested
]

{ #category : 'accessing' }
GtCompleter >> defaultStrategy [
	<return: #GtCompletionStrategy>
	
	^ defaultStrategy
]

{ #category : 'accessing' }
GtCompleter >> defaultStrategy: aGtCompletionStrategy [
	defaultStrategy := aGtCompletionStrategy
]

{ #category : 'initialization' }
GtCompleter >> initialize [
	super initialize.
	
	defaultStrategy := GtCompletionStrategy new.
	maxPopupItems := 10.
	showRequested := false
]

{ #category : 'accessing' }
GtCompleter >> maxCompletionItems [
	<return: #Number>
	
	^ maxPopupItems
]

{ #category : 'accessing' }
GtCompleter >> strategyAt: anIndex in: aBlText [
	"Choose a completion strategy for a given text index within a text"
	| aStrategy |
	
	aStrategy := self defaultStrategy.
	
	(aBlText attributesAt: anIndex)
		do: [ :eachAttribute |
			(eachAttribute isKindOf: GtCompletionStrategyAttribute)
				ifTrue: [ aStrategy := eachAttribute strategy ] ].
	^ aStrategy
]
