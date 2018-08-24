Class {
	#name : #GtPharoProgramNodeVisitor,
	#superclass : #SmaCCParseNodeVisitor,
	#category : 'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitArray: anArray [
	^ self visitValue: anArray
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitArrayLiteral: anArrayLiteral [
	^ self visitLiteral: anArrayLiteral
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitAssignment: anAssignment [
	^ self visitValue: anAssignment
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitBinaryMessage: aBinaryMessage [
	^ self visitMessage: aBinaryMessage
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitBlock: aBlock [
	^ self visitValue: aBlock
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitBlockError: aBlockError [
	^ self visitBlock: aBlockError
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitBooleanLiteral: aBooleanLiteral [
	^ self visitLiteral: aBooleanLiteral
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitByteArrayLiteral: aByteArrayLiteral [
	^ self visitArrayLiteral: aByteArrayLiteral
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitCascade: aCascade [
	^ self visitValue: aCascade
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitCharacterLiteral: aCharacterLiteral [
	^ self visitLiteral: aCharacterLiteral
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitError: anError [
	^ self visitValue: anError
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitErrorPattern: anErrorPattern [
	^ self visitMethodPattern: anErrorPattern
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitKeywordMessage: aKeywordMessage [
	^ self visitMessage: aKeywordMessage
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitLiteral: aLiteral [
	^ self visitValue: aLiteral
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitMessage: aMessage [
	^ self visitProgram: aMessage
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitMessageSend: aMessageSend [
	^ self visitValue: aMessageSend
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitMethod: aMethod [
	^ self visitProgram: aMethod
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitMethodPattern: aMethodPattern [
	^ self visitProgram: aMethodPattern
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitMethodSequence: aMethodSequence [
	^ self visitSequence: aMethodSequence
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitNilLiteral: aNilLiteral [
	^ self visitLiteral: aNilLiteral
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitNumberLiteral: aNumberLiteral [
	^ self visitLiteral: aNumberLiteral
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitPragma: aPragma [
	^ self visitProgram: aPragma
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitPragmaError: aPragmaError [
	^ self visitPragma: aPragmaError
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitProgram: aProgram [
	^ self visitSmaCCParseNode: aProgram
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitReturn: aReturn [
	^ self visitProgram: aReturn
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitSequence: aSequence [
	^ self visitProgram: aSequence
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitStringLiteral: aStringLiteral [
	^ self visitLiteral: aStringLiteral
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitSymbolLiteral: aSymbolLiteral [
	^ self visitLiteral: aSymbolLiteral
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitUnaryMessage: anUnaryMessage [
	^ self visitMessage: anUnaryMessage
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitValue: aValue [
	^ self visitProgram: aValue
]

{ #category : #generated }
GtPharoProgramNodeVisitor >> visitVariable: aVariable [
	^ self visitValue: aVariable
]
