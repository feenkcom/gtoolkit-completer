initialize-release
initialize
	super initialize.

	drillDownActions := OrderedCollection new.
	strategy := GtCompletionStrategy new.

	cursorElement := nil.

	listElement := self newCompletionList.
	overlay := self newPopupElement.
	overlay addChild: listElement.

	completionDelay := BlDelayedTaskAction new.
	completionDelay delay: self class popupDelay.

	lastWasText := false.
	ignoreTextEvents := false