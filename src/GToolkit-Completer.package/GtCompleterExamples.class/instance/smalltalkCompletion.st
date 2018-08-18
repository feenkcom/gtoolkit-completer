smalltalk
smalltalkCompletion
	<gtExample>
	^ self
		openOn: ''
		withStrategy: self smalltalkStrategy
		entering:
			#(0 'prin')
				,
					{[ :controller | self selectPreviewMatching: 'printOn:' in: controller ].
					#tabOn:.
					Character cr.
					Character tab} , #('is' #tabOn: $  'pr')
				,
					{[ :controller | self selectPreviewMatching: 'print:on:' in: controller ].
					#tabOn:} , #('ma' #tabOn: #tabOn: 'va' #tabOn:)

"printOn: aStream
	isMethod print: maxItems on: variables"