Class {
	#name : #GtPharoMessageSendNode,
	#superclass : #GtPharoValueNode,
	#instVars : [
		'receiver',
		'message'
	],
	#category : #'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoMessageSendNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitMessageSend: self
]

{ #category : #testing }
GtPharoMessageSendNode >> isMessageSend [
	^ true
]

{ #category : #generated }
GtPharoMessageSendNode >> message [
	^ message
]

{ #category : #generated }
GtPharoMessageSendNode >> message: aGtPharoMessageNode [
	self message notNil
		ifTrue: [ self message parent: nil ].
	message := aGtPharoMessageNode.
	self message notNil
		ifTrue: [ self message parent: self ]
]

{ #category : #generated }
GtPharoMessageSendNode >> nodeVariables [
	^ #(#receiver #message)
]

{ #category : #generated }
GtPharoMessageSendNode >> receiver [
	^ receiver
]

{ #category : #generated }
GtPharoMessageSendNode >> receiver: aGtPharoValueNode [
	self receiver notNil
		ifTrue: [ self receiver parent: nil ].
	receiver := aGtPharoValueNode.
	self receiver notNil
		ifTrue: [ self receiver parent: self ]
]

{ #category : #accessing }
GtPharoMessageSendNode >> selector [
	^ self message selector
]

{ #category : #accessing }
GtPharoMessageSendNode >> selectorParts [
	^ self message selectorParts
]
