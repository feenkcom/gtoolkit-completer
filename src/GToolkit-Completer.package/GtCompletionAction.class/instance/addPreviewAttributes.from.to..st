private-attributes
addPreviewAttributes: aText from: startIndex to: endIndex
	(aText from: (startIndex min: aText size) to: (endIndex min: aText size)) attributes: {PreviewAttribute}