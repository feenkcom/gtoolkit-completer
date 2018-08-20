*GToolkit-Completer
isLocallyDefined
	^ self allParents anySatisfy: [ :each | each defines: name value ]