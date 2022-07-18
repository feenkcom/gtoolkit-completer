Class {
	#name : #GtCalendarElement,
	#superclass : #BrHorizontalGrid,
	#instVars : [
		'date',
		'currentMonth'
	],
	#category : #'GToolkit-Completer-Calendar'
}

{ #category : #'instance creation' }
GtCalendarElement class >> forDate: aDate [
	^ (self new)
		date: aDate;
		yourself
]

{ #category : #'private ui' }
GtCalendarElement >> buildDays [
	| current last |
	current := currentMonth.
	last := currentMonth addMonths: 1.
	1
		to: current dayOfWeek - 1
		do: [ :i | self addChild: (BlElement new size: 0 @ 0) ].
	[ current < last ]
		whileTrue: [ | label selectedDate |
			selectedDate := current.
			label := BrButton new
					hMatchParent;
					vFitContent;
					padding: (BlInsets all: 1);
					layout: BlLinearLayout horizontal alignCenter;
					label: current dayOfMonth printString;
					action: [ self dispatchEvent: (GtCalendarDateClickedEvent forDate: selectedDate) ].
			date = current
				ifTrue: [ label
						geometry: BlCircleGeometry new;
						border: (BlBorder paint: BrGlamorousColors textHighlightColor width: 2) ].
			self addChild: label.
			current := current addDays: 1 ]
]

{ #category : #'private ui' }
GtCalendarElement >> buildHeader [
	self
		addChild: (BrButton new
				size: 10 @ 10;
				margin: (BlInsets top: 5 left: 5);
				aptitude: BrGlamorousButtonIconAptitude;
				icon: BrGlamorousVectorIcons left;
				layout: BlLinearLayout horizontal alignCenter;
				beTinySize;
				action: [ currentMonth := currentMonth addMonths: -1.
					self enqueueTask: (BlTaskAction new action: [ self buildMonth ]) ]).
	self
		addChild: (BrLabel new
				constraintsDo: [ :c | c grid horizontal span: 5 ];
				hMatchParent;
				layout: BlLinearLayout horizontal alignCenter;
				text: currentMonth monthName asString , ' ' , currentMonth year printString).
	self
		addChild: (BrButton new
				size: 10 @ 10;
				margin: (BlInsets top: 5 left: 7);
				aptitude: BrGlamorousButtonIconAptitude;
				icon: BrGlamorousVectorIcons right;
				layout: BlLinearLayout horizontal alignCenter;
				beTinySize;
				action: [ currentMonth := currentMonth addMonths: 1.
					self enqueueTask: (BlTaskAction new action: [ self buildMonth ]) ])
]

{ #category : #'private ui' }
GtCalendarElement >> buildMonth [
	self removeChildren.
	self buildHeader.
	self buildDays
]

{ #category : #accessing }
GtCalendarElement >> date: aDate [
	date := aDate.
	currentMonth := Date newDay: date firstDayOfMonth year: date year.
	self buildMonth
]

{ #category : #initialization }
GtCalendarElement >> initialize [
	super initialize.
	self columnCount: 7.
	self width: 150.
	self vFitContent
]
