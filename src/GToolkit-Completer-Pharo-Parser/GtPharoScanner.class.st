Class {
	#name : #GtPharoScanner,
	#superclass : #SmaCCScanner,
	#category : 'GToolkit-Completer-Pharo-Parser'
}

{ #category : #'generated-initialization' }
GtPharoScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(4 'false' 2) #(4 'nil' 3) #(4 'true' 1))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
GtPharoScanner >> barId [
	^ 6
]

{ #category : #generated }
GtPharoScanner >> binaryId [
	^ 26
]

{ #category : #generated }
GtPharoScanner >> emptySymbolTokenId [
	^ 94
]

{ #category : #generated }
GtPharoScanner >> errorTokenId [
	^ 95
]

{ #category : #generated }
GtPharoScanner >> keywordId [
	^ 25
]

{ #category : #generated }
GtPharoScanner >> nameAssignmentId [
	^ 5
]

{ #category : #generated }
GtPharoScanner >> nameId [
	^ 4
]

{ #category : #scanning }
GtPharoScanner >> negativeNumber [
	stream position: stream position - 2.
	^ self scanNumber: self negativeNumberId
]

{ #category : #generated }
GtPharoScanner >> negativeNumberId [
	^ 11
]

{ #category : #scanning }
GtPharoScanner >> number [
	stream position: stream position - 1.
	^ self scanNumber: self numberId
]

{ #category : #generated }
GtPharoScanner >> numberId [
	^ 10
]

{ #category : #generated }
GtPharoScanner >> scan1 [
	self step.
	currentCharacter == $"
		ifTrue: [ ^ self scan2 ].
	currentCharacter == $#
		ifTrue: [ ^ self scan3 ].
	currentCharacter == $$
		ifTrue: [ ^ self scan8 ].
	currentCharacter == $'
		ifTrue: [ ^ self scan9 ].
	^ self scan1X9
]

{ #category : #generated }
GtPharoScanner >> scan10 [
	self recordMatch: #(26).
	self step.
	currentCharacter isDigit
		ifTrue: [ ^ self recordAndReportMatch: #(11) ].
	currentCharacter isSpecial
		ifTrue: [ [ self recordMatch: #(26).
			self step.
			currentCharacter isSpecial ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan11 [
	[ self step.
	currentCharacter == $`
		ifTrue: [ self recordMatch: #(32).
			self step.
			currentCharacter == $`
				ifTrue: [ ^ self scan11 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GtPharoScanner >> scan12 [
	self recordMatch: #(12).
	self step.
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self step.
			currentCharacter == $:
				ifTrue: [ ^ self scan12 ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X1 [
	[ self recordMatch: #(31).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X2 [
	self recordMatch: #(25).
	self step.
	currentCharacter == $=
		ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X3 [
	self recordMatch: #(18).
	self step.
	currentCharacter == $=
		ifTrue: [ ^ self recordAndReportMatch: #(28) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X4 [
	self recordMatch: #(6 26).
	self step.
	currentCharacter isSpecial
		ifTrue: [ [ self recordMatch: #(26).
			self step.
			currentCharacter isSpecial ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X5 [
	self recordMatch: #(15 26).
	self step.
	currentCharacter isSpecial
		ifTrue: [ [ self recordMatch: #(26).
			self step.
			currentCharacter isSpecial ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X6 [
	self recordMatch: #(14 26).
	self step.
	currentCharacter isSpecial
		ifTrue: [ [ self recordMatch: #(26).
			self step.
			currentCharacter isSpecial ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X7 [
	[ self recordMatch: #(26).
	self step.
	currentCharacter isSpecial ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X8 [
	currentCharacter == ${
		ifTrue: [ ^ self recordAndReportMatch: #(16) ].
	currentCharacter == $|
		ifTrue:
			[ ^ self scan1X4 ].
	currentCharacter == $}
		ifTrue: [ ^ self recordAndReportMatch: #(24) ].
	currentCharacter isDigit
		ifTrue: [ ^ self recordAndReportMatch: #(10) ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ])
		ifTrue:
			[ ^ self scan1X1 ].
	currentCharacter isSpecial
		ifTrue:
			[ ^ self scan1X7 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self recordMatch: #(4).
			self step.
			currentCharacter == $:
				ifTrue:
					[ ^ self scan1X2 ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X9 [
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(19) ].
	currentCharacter == $)
		ifTrue: [ ^ self recordAndReportMatch: #(22) ].
	currentCharacter == $-
		ifTrue: [ ^ self scan10 ].
	currentCharacter == $.
		ifTrue: [ ^ self recordAndReportMatch: #(29) ].
	currentCharacter == $:
		ifTrue:
			[ ^ self scan1X3 ].
	currentCharacter == $;
		ifTrue: [ ^ self recordAndReportMatch: #(27) ].
	currentCharacter == $<
		ifTrue:
			[ ^ self scan1X6 ].
	currentCharacter == $>
		ifTrue:
			[ ^ self scan1X5 ].
	currentCharacter == $[
		ifTrue: [ ^ self recordAndReportMatch: #(17) ].
	currentCharacter == $]
		ifTrue: [ ^ self recordAndReportMatch: #(23) ].
	currentCharacter == $^
		ifTrue: [ ^ self recordAndReportMatch: #(13) ].
	currentCharacter == $`
		ifTrue: [ ^ self scan11 ].
	^ self scan1X8
]

{ #category : #generated }
GtPharoScanner >> scan2 [
	[ self step.
	currentCharacter == $"
		ifTrue: [ ^ self recordAndReportMatch: #(30) ].
	true ] whileTrue
]

{ #category : #generated }
GtPharoScanner >> scan3 [
	self step.
	currentCharacter == $#
		ifTrue: [ self step.
			currentCharacter == $'
				ifTrue: [ ^ self scan4 ].
			currentCharacter isSpecial
				ifTrue: [ [ self recordMatch: #(8).
					self step.
					currentCharacter isSpecial ] whileTrue.
					^ self reportLastMatch ].
			(currentCharacter isLetter or: [ currentCharacter == $_ ])
				ifTrue: [ ^ self scan5 ].
			^ self reportLastMatch ].
	currentCharacter == $'
		ifTrue: [ ^ self scan4 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(20) ].
	currentCharacter == $[
		ifTrue: [ ^ self recordAndReportMatch: #(21) ].
	currentCharacter isSpecial
		ifTrue: [ [ self recordMatch: #(8).
			self step.
			currentCharacter isSpecial ] whileTrue.
			^ self reportLastMatch ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan5 ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan4 [
	[ self step.
	currentCharacter == $'
		ifTrue: [ self recordMatch: #(8).
			self step.
			currentCharacter == $'
				ifTrue: [ ^ self scan4 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GtPharoScanner >> scan5 [
	[ self recordMatch: #(8).
	self step.
	currentCharacter == $:
		ifTrue: [ self recordMatch: #(8).
			self step.
			currentCharacter == $:
				ifTrue: [ ^ self scan6 ].
			(currentCharacter isLetter or: [ currentCharacter == $_ ])
				ifTrue: [ ^ self scan7 ].
			^ self reportLastMatch ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan6 [
	self step.
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self recordMatch: #(8).
			self step.
			currentCharacter == $:
				ifTrue: [ self step.
					currentCharacter == $:
						ifTrue: [ ^ self scan6 ].
					^ self reportLastMatch ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan7 [
	[ self step.
	currentCharacter == $:
		ifTrue: [ self recordMatch: #(8).
			self step.
			(currentCharacter isLetter or: [ currentCharacter == $_ ])
				ifTrue: [ ^ self scan7 ].
			^ self reportLastMatch ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan8 [
	self step.
	^ self recordAndReportMatch: #(9)
]

{ #category : #generated }
GtPharoScanner >> scan9 [
	[ self step.
	currentCharacter == $'
		ifTrue: [ self recordMatch: #(7).
			self step.
			currentCharacter == $'
				ifTrue: [ ^ self scan9 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GtPharoScanner >> scanForToken [
	scope == #literalArray
		ifTrue:
			[ ^ self scanForTokenX1 ].
	scope == #default
		ifTrue: [ ^ self scan1 ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scanForTokenX1 [
	self step.
	currentCharacter == $"
		ifTrue: [ ^ self scan2 ].
	currentCharacter == $#
		ifTrue: [ ^ self scan3 ].
	currentCharacter == $$
		ifTrue: [ ^ self scan8 ].
	currentCharacter == $'
		ifTrue: [ ^ self scan9 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(19) ].
	currentCharacter == $)
		ifTrue: [ ^ self recordAndReportMatch: #(22) ].
	currentCharacter == $-
		ifTrue: [ ^ self scan10 ].
	currentCharacter == $.
		ifTrue: [ ^ self recordAndReportMatch: #(29) ].
	^ self scanForTokenX1X3
]

{ #category : #generated }
GtPharoScanner >> scanForTokenX1X1 [
	[ self recordMatch: #(31).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scanForTokenX1X2 [
	[ self recordMatch: #(26).
	self step.
	currentCharacter isSpecial ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scanForTokenX1X3 [
	currentCharacter == $;
		ifTrue: [ ^ self recordAndReportMatch: #(27) ].
	currentCharacter == $[
		ifTrue: [ ^ self recordAndReportMatch: #(17) ].
	currentCharacter == $]
		ifTrue: [ ^ self recordAndReportMatch: #(23) ].
	currentCharacter isDigit
		ifTrue: [ ^ self recordAndReportMatch: #(10) ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ])
		ifTrue:
			[ ^ self scanForTokenX1X1 ].
	currentCharacter isSpecial
		ifTrue:
			[ ^ self scanForTokenX1X2 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self recordMatch: #(4).
			self step.
			currentCharacter == $:
				ifTrue: [ ^ self scan12 ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #scanning }
GtPharoScanner >> scanNumber: anInteger [
	| end |
	matchActions := Array with: anInteger.
	[ Number readFrom: stream ]
		on: Error
		do: [ :ex | matchActions := #(0) ].
	outputStream reset.
	end := stream position.
	stream position: start.
	^ self createTokenFor: (stream next: end - start)
]

{ #category : #generated }
GtPharoScanner >> tokenActions [
	^ #(nil nil nil nil nil nil nil nil nil #number #negativeNumber nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil #comment #whitespace #patternToken)
]
