Class {
	#name : #GtRenameAttribute,
	#superclass : #BrTextBackgroundAttribute,
	#category : #'GToolkit-Completer'
}

{ #category : #'initialize-release' }
GtRenameAttribute >> initialize [
	super initialize.
	self beNotOverwritableByStyler.
	self paint: (Color gray alpha: 0.4)
]
