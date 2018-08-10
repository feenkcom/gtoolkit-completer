private
nextUncompletedItem
	| text position |
	text := self text.
	position := self textEditor cursor position.
	[ position <= text size and: [ self isUncompletedAt: position ] ] whileTrue: [ position := position + 1 ].
	[ position <= text size ]
		whileTrue: [ (self isUncompletedAt: position)
				ifTrue: [ self textEditor select: position to: position + 1.
					^ position ].
			position := position + 1 ].
	^ nil