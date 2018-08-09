*GToolkit-Completer
guessType: aClass
	name value = 'self'
		ifTrue: [ ^ aClass ].
	name value = 'super'
		ifTrue: [ ^ aClass superclass ].
	^ super guessType: aClass