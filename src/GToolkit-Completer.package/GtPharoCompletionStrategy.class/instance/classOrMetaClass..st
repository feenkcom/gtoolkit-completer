accessing
classOrMetaClass: aClass
	class := aClass.
	class notNil
		ifTrue: [ variables addAll: class allInstVarNames.
			class isMeta
				ifTrue: [ variables addAll: class baseClass allClassVarNames ]
				ifFalse: [ variables addAll: class allClassVarNames ].
			class superclass notNil
				ifTrue: [ variables add: 'super' ] ]