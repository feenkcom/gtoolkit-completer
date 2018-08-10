testing
isAtStartOfLine
	| text position char |
	text := self text.
	position := self textEditor cursor position.
	[ position > 0 and: [ (char := text at: position) isSeparator ] ]
		whileTrue: [ (char = Character cr or: [ char = Character lf ])
				ifTrue: [ ^ true ].
			position := position - 1 ].
	^ position <= 0