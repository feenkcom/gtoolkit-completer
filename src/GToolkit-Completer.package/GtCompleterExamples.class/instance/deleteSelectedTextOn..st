private
deleteSelectedTextOn: completionController
	completionController textEditor selection allSelections
		do: [ :each | 
			each from < each to
				ifTrue: [ completionController textEditor delete: each from to: each to.
					^ completionController textEditor selectNone ] ]