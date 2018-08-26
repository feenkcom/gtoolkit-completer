Class {
	#name : #GtPreviewCompletionAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'string'
	],
	#category : #'GToolkit-Completer'
}

{ #category : #'instance creation' }
GtPreviewCompletionAttribute class >> for: aString [
	^ self new
		for: aString;
		beAppend;
		beNotOverwritableByStyler;
		yourself
]

{ #category : #accessing }
GtPreviewCompletionAttribute >> affect: aBrText in: anEditorElement [
	| text attributes |
	text := string asRopedText.
	attributes := (anEditorElement editor text attributesAt: aBrText end) reject: [ :each | each = self ].
	text attributes: attributes.
	^ (BlTextElement text: text)
		background: (BrGlamorousColors lightBorderColor);
		padding: (BlInsets top: 3 left: 0 bottom: 3 right: 0);
		yourself
]

{ #category : #'initialize-release' }
GtPreviewCompletionAttribute >> for: aString [
	string := aString
]
