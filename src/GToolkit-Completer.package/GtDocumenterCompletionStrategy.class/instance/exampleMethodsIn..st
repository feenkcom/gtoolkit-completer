private
exampleMethodsIn: aClass
	^ GtPrefixTree withAll: ((aClass selectors select: [ :each | aClass >> each hasPragmaNamed: #gtExample ]) collect: [ :each | each ])