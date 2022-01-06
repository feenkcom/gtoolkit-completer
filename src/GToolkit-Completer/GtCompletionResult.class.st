Class {
	#name : #GtCompletionResult,
	#superclass : #Object,
	#category : #'GToolkit-Completer-Results'
}

{ #category : #'instance creation' }
GtCompletionResult class >> empty [
	^ self new
]

{ #category : #testing }
GtCompletionResult >> hasCompletionActions [
	^ false
]

{ #category : #accessing }
GtCompletionResult >> popupPosition [
	^ nil
]

{ #category : #showing }
GtCompletionResult >> showOn: aController [
	aController removePopup
]
