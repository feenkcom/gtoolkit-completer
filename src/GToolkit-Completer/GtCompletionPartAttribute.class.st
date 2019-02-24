Class {
	#name : #GtCompletionPartAttribute,
	#superclass : #BlTextAttribute,
	#category : #'GToolkit-Completer'
}

{ #category : #'initialize-release' }
GtCompletionPartAttribute >> initialize [
	super initialize.
	self beNotOverwritableByStyler
]
