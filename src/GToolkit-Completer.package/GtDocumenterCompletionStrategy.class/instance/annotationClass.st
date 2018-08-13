private-annotations
annotationClass
	^ PRAbstractAnnotation withAllSubclasses
		detect: [ :each | each tag = tagName ]
		ifNone: [ nil ]