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
	| text attributes textElement |
	text := string asRopedText.
	attributes := (anEditorElement editor text attributesAt: aBrText end) reject: [ :each | each = self ].
	text attributes: attributes.
	textElement := (BlTextElement text: text)
		ascentBaseline;
		looseMesurement;
		background: (BrGlamorousColors lightBorderColor alpha: 0.5);
		yourself.
	attributes 
		detect: [:each | each isKindOf: BrTextParagraphLineSpacingAttribute]
		ifFound: [ :lineSpacingAttribute | 
			textElement padding: (BlInsets 
				top: (lineSpacingAttribute lineSpacing / 2) 
				bottom: (lineSpacingAttribute lineSpacing / 2)) ].	
	^ textElement
]

{ #category : #'initialize-release' }
GtPreviewCompletionAttribute >> for: aString [
	string := aString
]
