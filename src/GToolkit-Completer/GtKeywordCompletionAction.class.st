Class {
	#name : #GtKeywordCompletionAction,
	#superclass : #GtParenthesizedMessageCompletionAction,
	#category : #'GToolkit-Completer-Pharo'
}

{ #category : #private }
GtKeywordCompletionAction >> messageAndArgumentNamesDo: aBlock [
	text first = $:
		ifTrue: [ aBlock value: ':' value: '_' ].
	(text substrings: ':') do: [ :each | aBlock value: each , ':' value: '_' ]
]
