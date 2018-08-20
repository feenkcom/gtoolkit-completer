*GToolkit-Completer
defines: aString
	^ self variables anySatisfy: [ :each | each name value = aString ]