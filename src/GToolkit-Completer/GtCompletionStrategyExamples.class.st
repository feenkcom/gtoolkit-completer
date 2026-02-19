Class {
	#name : #GtCompletionStrategyExamples,
	#superclass : #Object,
	#category : #'GToolkit-Completer-Examples'
}

{ #category : #examples }
GtCompletionStrategyExamples >> prefixAfterMultipleSeparators [
	<gtExample>
	<return: #String>
	| strategy prefix |
	strategy := GtStreamedCompletionStrategy new.
	prefix := strategy completionPrefixAt: 9 in: 'hi  there'.
	self assert: prefix equals: 'there'.
	^ prefix
]

{ #category : #examples }
GtCompletionStrategyExamples >> prefixAfterSeparatorLongerWord [
	<gtExample>
	<return: #String>
	| strategy prefix |
	strategy := GtStreamedCompletionStrategy new.
	prefix := strategy completionPrefixAt: 11 in: 'hello world'.
	self assert: prefix equals: 'world'.
	^ prefix
]

{ #category : #examples }
GtCompletionStrategyExamples >> prefixAfterSeparatorSingleCharacter [
	<gtExample>
	<return: #String>
	| strategy prefix |
	strategy := GtStreamedCompletionStrategy new.
	prefix := strategy completionPrefixAt: 3 in: 'a b'.
	self assert: prefix equals: 'b'.
	^ prefix
]

{ #category : #examples }
GtCompletionStrategyExamples >> prefixAtIndexBelowMinimumLength [
	<gtExample>
	<return: #Object>
	| strategy prefix |
	strategy := GtStreamedCompletionStrategy new.
	prefix := strategy completionPrefixAt: 0 in: 'a'.
	self assert: prefix equals: nil.
	^ prefix
]

{ #category : #examples }
GtCompletionStrategyExamples >> prefixAtLeadingSeparatorIsNil [
	<gtExample>
	<return: #Object>
	| strategy prefix |
	strategy := GtStreamedCompletionStrategy new.
	prefix := strategy completionPrefixAt: 1 in: ' hello'.
	self assert: prefix equals: nil.
	^ prefix
]

{ #category : #examples }
GtCompletionStrategyExamples >> prefixAtMinimumLengthWithoutSeparator [
	<gtExample>
	<return: #String>
	| strategy prefix |
	strategy := GtStreamedCompletionStrategy new.
	prefix := strategy completionPrefixAt: 1 in: 'a'.
	self assert: prefix equals: 'a'.
	^ prefix
]

{ #category : #examples }
GtCompletionStrategyExamples >> prefixAtSeparatorCharacterIsNil [
	<gtExample>
	<return: #Object>
	| strategy prefix |
	strategy := GtStreamedCompletionStrategy new.
	prefix := strategy completionPrefixAt: 2 in: 'a b'.
	self assert: prefix equals: nil.
	^ prefix
]

{ #category : #examples }
GtCompletionStrategyExamples >> prefixWithoutSeparatorLaterIndex [
	<gtExample>
	<return: #String>
	| strategy prefix |
	strategy := GtStreamedCompletionStrategy new.
	prefix := strategy completionPrefixAt: 4 in: 'abcdef'.
	self assert: prefix equals: 'abcd'.
	^ prefix
]
