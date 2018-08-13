private
exampleMethodsStartingWith: aString
	| index spaceIndex class name prefix |
	index := aString indexOfSubCollection: '>>#'.
	index > 0
		ifTrue: [ name := aString copyFrom: 1 to: index - 1.
			spaceIndex := name indexOf: $  ifAbsent: [ name size + 1 ].
			class := Smalltalk at: (name copyFrom: 1 to: spaceIndex - 1) asSymbol ifAbsent: [ ^ #() ].
			(name includes: $ )
				ifTrue: [ class := class class ].
			prefix := aString allButFirst: index + 2.
			^ ((self exampleMethodsIn: class) first: max startingWith: prefix)
				collect: [ :each | 
					self
						complete: each
						with: (each allButFirst: prefix size)
						deleting: 0
						at: position ] ].
	^ (self exampleClasses first: max startingWith: aString)
		collect: [ :each | 
			self
				complete: each
				with: (each allButFirst: aString size) , '>>#'
				deleting: 0
				at: position ]