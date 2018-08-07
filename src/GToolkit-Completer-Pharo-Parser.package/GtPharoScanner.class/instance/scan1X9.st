generated
scan1X9
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