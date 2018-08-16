private
fromIndex
	^ parenIndex isNil
		ifTrue: [ super fromIndex ]
		ifFalse: [ parenIndex ]