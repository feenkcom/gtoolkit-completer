Class {
	#name : #GtCalendarDateClickedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'date',
		'clickEvent'
	],
	#category : #'GToolkit-Completer-Calendar'
}

{ #category : #'instance creation' }
GtCalendarDateClickedEvent class >> forDate: aDate [
	^ (self new)
		date: aDate;
		yourself
]

{ #category : #accessing }
GtCalendarDateClickedEvent >> clickEvent [
	^ clickEvent
]

{ #category : #accessing }
GtCalendarDateClickedEvent >> clickEvent: aBlClickEvent [
	clickEvent := aBlClickEvent
]

{ #category : #accessing }
GtCalendarDateClickedEvent >> date [
	^ date
]

{ #category : #accessing }
GtCalendarDateClickedEvent >> date: aDate [
	date := aDate
]
