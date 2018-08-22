private - popup
updatePopupItemsAt: anIndex autoSelect: shouldSelectFirst
	| theActions |

	theActions := [ (self strategyAt: anIndex) completionActionsFor: self text at: anIndex max: MaxPopupItems ]
		on: Error
		do: [ :ex | ex return: #() ].

	"action is deselected => preview is cancelled"
	self deselectAll.
	self completionActions: theActions.

	theActions
		ifEmpty: [ ^ self removePopup ].

	shouldSelectFirst
		ifFalse: [ ^ self ].

	"first item is selected => preview is shown"
	self selectFirst