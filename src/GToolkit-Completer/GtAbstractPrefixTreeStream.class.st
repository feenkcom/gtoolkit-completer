Class {
	#name : #GtAbstractPrefixTreeStream,
	#superclass : #Object,
	#traits : 'TAsyncStream',
	#classTraits : 'TAsyncStream classTrait',
	#instVars : [
		'root',
		'prefix',
		'caseSensitive'
	],
	#category : #'GToolkit-Completer-PrefixTree'
}

{ #category : #'instance creation' }
GtAbstractPrefixTreeStream class >> tree: aPrefixTree prefix: aString [
	^ (self new)
		tree: aPrefixTree prefix: aString;
		yourself
]

{ #category : #'instance creation' }
GtAbstractPrefixTreeStream class >> tree: aPrefixTree prefix: aString caseSensitive: aBoolean [
	^ self new
		tree: aPrefixTree prefix: aString;
		caseSensitive: aBoolean;
		yourself
]

{ #category : #'instance creation' }
GtAbstractPrefixTreeStream >> caseSensitive: aBoolean [
	caseSensitive := aBoolean
]

{ #category : #accessing }
GtAbstractPrefixTreeStream >> initialize [
	super initialize.
	caseSensitive := true
]

{ #category : #private }
GtAbstractPrefixTreeStream >> nodesDo: aBlock [
	root
		findNodes: prefix
		caseSensitive: caseSensitive
		current: ''
		do: aBlock
]

{ #category : #accessing }
GtAbstractPrefixTreeStream >> tree: aPrefixTree prefix: aString [
	root := aPrefixTree.
	prefix := aString
]
