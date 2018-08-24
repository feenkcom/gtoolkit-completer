Class {
	#name : #BrRBMethodBodyTextStyler,
	#superclass : #BrRBTextStyler,
	#instVars : [
		'methodPatternSource'
	],
	#category : 'GToolkit-Completer-Pharo'
}

{ #category : #adding }
BrRBMethodBodyTextStyler >> addAttributes: attributes from: start to: stop [
	| length |
	length := methodPatternSource size + 1.
	start <= length
		ifTrue: [ ^ self ].
	^ super addAttributes: attributes from: start - length to: stop - length
]

{ #category : #accessing }
BrRBMethodBodyTextStyler >> methodPatternSource: aString [
	methodPatternSource := aString
]

{ #category : #parsing }
BrRBMethodBodyTextStyler >> parse: aText isMethod: isMethod [
	| source |
	source := methodPatternSource , ' ' , aText asString.
	^ super parse: source isMethod: true
]
