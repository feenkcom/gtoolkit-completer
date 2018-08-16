private-attributes
addSearchAttributes: aText from: startIndex to: endIndex
	(aText from: (startIndex min: aText size) to: (endIndex min: aText size)) attributes: {SearchAttribute}