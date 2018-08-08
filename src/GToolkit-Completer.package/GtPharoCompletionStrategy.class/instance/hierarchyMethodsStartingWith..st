private-method
hierarchyMethodsStartingWith: aString
	| methods |
	class isNil
		ifTrue: [ ^ #() ].
	methods := OrderedCollection new.
	class
		allSuperclassesDo: [ :each | methods addAll: ((each selectors select: [ :sel | sel beginsWith: aString ]) asSortedCollection collect: [ :sel | each >> sel ]) ].
	class
		allSubclassesDo: [ :each | methods addAll: ((each selectors select: [ :sel | sel beginsWith: aString ]) asSortedCollection collect: [ :sel | each >> sel ]) ].
	^ methods