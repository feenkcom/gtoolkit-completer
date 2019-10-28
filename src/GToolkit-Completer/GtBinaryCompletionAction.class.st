Class {
	#name : #GtBinaryCompletionAction,
	#superclass : #GtParenthesizedMessageCompletionAction,
	#category : #'GToolkit-Completer-Pharo'
}

{ #category : #enumerating }
GtBinaryCompletionAction >> messageAndArgumentNamesDo: aBlock [
	aBlock value: text value: '_'
]
