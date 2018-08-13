private
exampleClasses
	^ exampleClasses
		ifNil: [ exampleClasses := GtPrefixTree
				withAll:
					((ProtoObject withAllSubclasses select: [ :each | each selectors anySatisfy: [ :sel | each >> sel hasPragmaNamed: #gtExample ] ])
						collect: [ :each | each name ]) ]