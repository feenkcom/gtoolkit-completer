private
allAnnotationActions
	^ (annotationTags first: max startingWith: '$')
		collect: [ :each | 
			self
				complete: each
				with: each allButFirst
				deleting: 0
				at: position ]