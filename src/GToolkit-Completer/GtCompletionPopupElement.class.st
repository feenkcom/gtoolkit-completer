Class {
	#name : #GtCompletionPopupElement,
	#superclass : #BlElement,
	#instVars : [
		'referenceElement',
		'overlayListener'
	],
	#category : #'GToolkit-Completer-UI'
}

{ #category : #'api - attaching / detaching' }
GtCompletionPopupElement >> attachTo: anElement [
	
	referenceElement = anElement
		ifTrue: [ ^ self ].
	
	self isAttached 
		ifTrue: [ self detach ].
	
	referenceElement := anElement.
	anElement addEventHandler: overlayListener
]

{ #category : #'api - attaching / detaching' }
GtCompletionPopupElement >> detach [
	
	self isAttached
		ifFalse: [ ^ self ].
	
	referenceElement removeEventHandler: overlayListener.
	referenceElement := nil
]

{ #category : #initialization }
GtCompletionPopupElement >> initialize [
	super initialize.

	self constraintsDo: [ :c | c ignoreByLayout ].

	overlayListener := GtCompletionPopupListener for: self
]

{ #category : #'api - testing' }
GtCompletionPopupElement >> isAttached [
	"Return true if I am attached to any element, false otherwise"
	<return: #Boolean>

	^ referenceElement isNotNil
]

{ #category : #layout }
GtCompletionPopupElement >> measureMyBounds [
	"I compute by position and size in relation to the reference element"
	self
		assert: [ self isAttached ]
		description: [ 'I must be attached to the reference element to measure myself' ].

	self relocate: (overlayListener positionFor: referenceElement)
]

{ #category : #layout }
GtCompletionPopupElement >> onMeasure: anExtentMeasurementSpec [

	self isAttached
		ifTrue: [ self measureMyBounds ].

	super onMeasure: anExtentMeasurementSpec
]
