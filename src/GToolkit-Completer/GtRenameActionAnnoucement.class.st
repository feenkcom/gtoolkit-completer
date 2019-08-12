Class {
	#name : #GtRenameActionAnnoucement,
	#superclass : #Announcement,
	#instVars : [
		'renameAction',
		'eventType'
	],
	#category : #'GToolkit-Completer'
}

{ #category : #'instance creation' }
GtRenameActionAnnoucement class >> for: aRenameAction type: aSymbol [
	^ self new
		renameAction: aRenameAction;
		eventType: aSymbol;
		yourself
]

{ #category : #accessing }
GtRenameActionAnnoucement >> eventType [
	^ eventType
]

{ #category : #accessing }
GtRenameActionAnnoucement >> eventType: aSymbol [
	eventType := aSymbol
]

{ #category : #accessing }
GtRenameActionAnnoucement >> renameAction [
	^ renameAction
]

{ #category : #accessing }
GtRenameActionAnnoucement >> renameAction: aRenameAction [
	renameAction := aRenameAction
]
