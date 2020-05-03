Class {
	#name : #GtRenameActionAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'renameAction',
		'eventType'
	],
	#category : #'GToolkit-Completer'
}

{ #category : #'instance creation' }
GtRenameActionAnnouncement class >> for: aRenameAction type: aSymbol [
	^ self new
		renameAction: aRenameAction;
		eventType: aSymbol;
		yourself
]

{ #category : #accessing }
GtRenameActionAnnouncement >> eventType [
	^ eventType
]

{ #category : #accessing }
GtRenameActionAnnouncement >> eventType: aSymbol [
	eventType := aSymbol
]

{ #category : #accessing }
GtRenameActionAnnouncement >> renameAction [
	^ renameAction
]

{ #category : #accessing }
GtRenameActionAnnouncement >> renameAction: aRenameAction [
	renameAction := aRenameAction
]
