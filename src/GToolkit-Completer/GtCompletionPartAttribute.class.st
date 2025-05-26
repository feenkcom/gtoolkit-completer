Class {
	#name : #GtCompletionPartAttribute,
	#superclass : #BlTextAttribute,
	#category : #'GToolkit-Completer-Attributes'
}

{ #category : #'initialize-release' }
GtCompletionPartAttribute >> initialize [
	super initialize.
	self beNotOverwritableByStyler.
	self shouldPropagate: false
]
