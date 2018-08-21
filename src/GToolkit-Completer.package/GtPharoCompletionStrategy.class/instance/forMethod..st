accessing
forMethod: aCompiledMethod
	| source ast |
	self classOrMetaClass: aCompiledMethod methodClass.
	source := aCompiledMethod sourceCode.
	ast := GtPharoParser parse: source.
	self methodPattern: ast pattern