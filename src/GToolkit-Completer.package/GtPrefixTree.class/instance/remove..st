removing
remove: aString
	"Unlike normal collections, we don't throw an error if we remove something that isn't in the tree."

	^ self remove: aString weight: 1