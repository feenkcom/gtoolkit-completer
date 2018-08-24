Class {
	#name : #GtCompletionPopupListener,
	#superclass : #BlElementEventListener,
	#instVars : [
		'overlayElement',
		'attachmentsCount'
	],
	#category : 'GToolkit-Completer-UI'
}

{ #category : #'instance creation' }
GtCompletionPopupListener class >> for: anOverlayElement [
	^ self basicNew
		initialize;
		overlayElement: anOverlayElement
]

{ #category : #'instance creation' }
GtCompletionPopupListener class >> new [
	self error: 'Do not create an instance of ', self name, ' using new. Please use #for: instead'
]

{ #category : #'element handlers' }
GtCompletionPopupListener >> elementPositionInSpaceChanged: anEvent [
	self relocateTo: anEvent currentTarget
]

{ #category : #initialization }
GtCompletionPopupListener >> initialize [
	super initialize.
	
	attachmentsCount := 0
]

{ #category : #'api - hooks' }
GtCompletionPopupListener >> onInstalledIn: anElement [
	self
		assert: [ attachmentsCount isZero ]
		description: [ 'I must be attached to at most one element' ].
		
	attachmentsCount := attachmentsCount + 1.
	
	self relocateTo: anElement
]

{ #category : #'api - hooks' }
GtCompletionPopupListener >> onUninstalledIn: anObject [
	
	self
		assert: [ attachmentsCount = 1 ]
		description: [ 'I must be attached to at most one element' ].
	
	attachmentsCount := attachmentsCount - 1
]

{ #category : #accessing }
GtCompletionPopupListener >> overlayElement [
	<return: #BlOverlayElement>

	^ overlayElement
]

{ #category : #accessing }
GtCompletionPopupListener >> overlayElement: anOverlayElement [

	self
		assert: [ anOverlayElement isNotNil ]
		description: [ 'Overlay element must not be nil' ].

	overlayElement := anOverlayElement
]

{ #category : #geometry }
GtCompletionPopupListener >> positionFor: anElement [
	<return: #Point>
	| boundsInSpace |
	self
		assert: [ anElement isNotNil ]
		description: [ 'Reference element must not be nil' ].
	
	boundsInSpace := anElement bounds inSpace.
	
	^ (self overlayElement globalPointToParent: boundsInSpace position + boundsInSpace extent)
]

{ #category : #'api - updating' }
GtCompletionPopupListener >> relocateTo: anElement [
	self overlayElement relocate: (self positionFor: anElement)
]
