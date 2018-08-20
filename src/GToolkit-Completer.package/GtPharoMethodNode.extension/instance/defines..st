*GToolkit-Completer
defines: aString
	^ variables anySatisfy: [ :each | each name value = aString ]