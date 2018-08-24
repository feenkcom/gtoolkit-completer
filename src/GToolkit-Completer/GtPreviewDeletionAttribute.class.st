Class {
	#name : #GtPreviewDeletionAttribute,
	#superclass : #BrTextAttribute,
	#category : #'GToolkit-Completer'
}

{ #category : #drawing }
GtPreviewDeletionAttribute >> drawAboveOnSpartaCanvas: aSpartaCanvas with: aSpartaSpan [
	aSpartaCanvas stroke
		paint: self paint;
		path:
			(aSpartaCanvas shape
				line: (aSpartaSpan baseline - (0 @ (aSpartaSpan height / 2))) rounded
				to: ((aSpartaSpan width + aSpartaSpan baseline x) @ aSpartaSpan baseline y - (0 @ (aSpartaSpan height / 2))) rounded);
		width: 3;
		draw
]

{ #category : #comparing }
GtPreviewDeletionAttribute >> equals: aTextAttribute [
	^ self == aTextAttribute
]

{ #category : #comparing }
GtPreviewDeletionAttribute >> hash [
	^ self identityHash
]

{ #category : #drawing }
GtPreviewDeletionAttribute >> paint [
	^ Color red
]
