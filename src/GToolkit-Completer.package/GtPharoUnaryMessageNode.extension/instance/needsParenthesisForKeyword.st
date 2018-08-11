*GToolkit-Completer
needsParenthesisForKeyword
	| messageSendParent |
	messageSendParent := parent parent.
	^ (messageSendParent isKindOf: GtPharoMessageNode)
		or: [ (messageSendParent isKindOf: GtPharoMessageSendNode) or: [ messageSendParent isKindOf: GtPharoCascadeNode ] ]