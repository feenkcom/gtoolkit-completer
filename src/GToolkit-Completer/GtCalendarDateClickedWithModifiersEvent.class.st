Class {
	#name : #GtCalendarDateClickedWithModifiersEvent,
	#superclass : #BlEvent,
	#instVars : [
		'date',
		'modifiers'
	],
	#category : #'GToolkit-Completer-Calendar'
}

{ #category : #'instance creation' }
GtCalendarDateClickedWithModifiersEvent class >> forDate: aDate modifiers: aModifiers [
	^ (self new)
		date: aDate;
		modifiers: aModifiers;
		yourself
]

{ #category : #accessing }
GtCalendarDateClickedWithModifiersEvent >> date [
	^ date
]

{ #category : #accessing }
GtCalendarDateClickedWithModifiersEvent >> date: aDate [
	date := aDate
]

{ #category : #accessing }
GtCalendarDateClickedWithModifiersEvent >> modifiers [
	^ modifiers
]

{ #category : #accessing }
GtCalendarDateClickedWithModifiersEvent >> modifiers: anObject [
	modifiers := anObject
]
