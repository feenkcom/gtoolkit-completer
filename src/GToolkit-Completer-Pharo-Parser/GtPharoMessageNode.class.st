Class {
	#name : #GtPharoMessageNode,
	#superclass : #GtPharoProgramNode,
	#category : 'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoMessageNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitMessage: self
]

{ #category : #accessing }
GtPharoMessageNode >> selector [
	^ self subclassResponsibility
]
