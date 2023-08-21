Class {
	#name : #GtCalendarCompletionResult,
	#superclass : #GtCompletionResult,
	#instVars : [
		'date',
		'interval'
	],
	#category : #'GToolkit-Completer-Calendar'
}

{ #category : #'instance creation' }
GtCalendarCompletionResult class >> forDate: aDate andInterval: anInterval [
	^ (self new)
		date: aDate;
		interval: anInterval;
		yourself
]

{ #category : #private }
GtCalendarCompletionResult >> actionForDate: aDate [
	| insertionAction text |
	text := aDate iso8601.
	insertionAction := GtInsertTextCompletionAction
		labeled: text
		completion: text
		position: interval first - 1
		from: interval first - 1.
	interval last > interval first
		ifTrue:
			[ ^ (GtCompositeCompletionAction labeled: text)
				addAction:
						(GtDeleteTextCompletionAction
								labeled: text
								from: interval first
								to: interval last - 1);
				addAction: insertionAction ].
	^ insertionAction
]

{ #category : #accessing }
GtCalendarCompletionResult >> asAsyncStream [
	self error: 'Calendar completion can''t be converted into a stream'
]

{ #category : #initialization }
GtCalendarCompletionResult >> date: aDate [
	date := aDate
]

{ #category : #testing }
GtCalendarCompletionResult >> hasCompletionActions [
	^ true
]

{ #category : #initialization }
GtCalendarCompletionResult >> initialize [
	super initialize.
	date := Date today
]

{ #category : #initialization }
GtCalendarCompletionResult >> interval: anInterval [
	interval := anInterval
]

{ #category : #showing }
GtCalendarCompletionResult >> showOn: aController [
	| element |
	element := GtCalendarElement forDate: date.
	element
		when: GtCalendarDateClickedEvent
		do:
			[ :event | element enqueueTask: (BlTaskAction new action: [ aController completeWithAction: (self actionForDate: event date) ]) ].
	aController popupElement: element
]
