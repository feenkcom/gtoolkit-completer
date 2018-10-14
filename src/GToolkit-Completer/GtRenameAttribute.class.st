Class {
	#name : #GtRenameAttribute,
	#superclass : #BlTextUnderlineAttribute,
	#category : #'GToolkit-Completer'
}

{ #category : #'initialize-release' }
GtRenameAttribute >> initialize [
	super initialize.
	self beNotOverwritableByStyler.
	self paint: (Color gray alpha: 0.4)
]
