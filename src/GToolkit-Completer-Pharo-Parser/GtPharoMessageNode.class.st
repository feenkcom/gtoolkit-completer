Class {
	#name : #GtPharoMessageNode,
	#superclass : #GtPharoProgramNode,
	#category : #'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoMessageNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitMessage: self
]

{ #category : #testing }
GtPharoMessageNode >> isBinary [
	^ false
]

{ #category : #testing }
GtPharoMessageNode >> isKeyword [
	^ false
]

{ #category : #testing }
GtPharoMessageNode >> isUnary [
	^ false
]

{ #category : #accessing }
GtPharoMessageNode >> selector [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPharoMessageNode >> selectorParts [
	^ self subclassResponsibility
]
