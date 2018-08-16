private-attributes
removeAttributes: aText from: startIndex to: endIndex
	aText
		clearAttributes: (startIndex min: aText size)
		to: (endIndex min: aText size)
		if: [ :attr | attr == SearchAttribute or: [ attr == PreviewAttribute ] ]