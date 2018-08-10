private
removeUncompletedAttributeAt: anInteger
	| text position |
	text := self text.
	position := anInteger.
	[ position <= text size and: [ self isUncompletedAt: position ] ] whileTrue: [ position := position + 1 ].
	(text from: anInteger to: position - 1) clearAttributes: [ :each | each isKindOf: GtCompletionPartAttribute ]