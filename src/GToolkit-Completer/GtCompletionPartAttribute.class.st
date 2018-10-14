Class {
	#name : #GtCompletionPartAttribute,
	#superclass : #BlTextAttribute,
	#category : #'GToolkit-Completer'
}

{ #category : #comparing }
GtCompletionPartAttribute >> equals: aTextAttribute [
	^ self class = aTextAttribute class
]

{ #category : #comparing }
GtCompletionPartAttribute >> hash [
	^ self class hash
]

{ #category : #'initialize-release' }
GtCompletionPartAttribute >> initialize [
	super initialize.
	self beNotOverwritableByStyler
]
