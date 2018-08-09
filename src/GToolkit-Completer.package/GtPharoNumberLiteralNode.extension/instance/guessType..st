*GToolkit-Completer
guessType: aClass
	^ [ (Number readFrom: value source) class ]
		on: Error
		do: [ :ex | ex return: Number ]