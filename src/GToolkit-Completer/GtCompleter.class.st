"
#Completer
Is responsible for synchronous and asynchronous completion computation.

The asynchronous computation happens in the following worker pool:
```
BlTktWorkerProvider completionPool
```


"
Class {
	#name : #GtCompleter,
	#superclass : #Object,
	#instVars : [
		'defaultStrategy',
		'showRequested',
		'completerMonitor',
		'completerPromise'
	],
	#category : #'GToolkit-Completer-Model'
}

{ #category : #completion }
GtCompleter >> complete: aBlText at: anIndex [
	"Compute completion actions syncronously for a given text and an index"
	<return: #GtCompletionResult>

	^ (self strategyAt: anIndex in: aBlText)
		completionResultFor: aBlText
		at: anIndex
		requested: showRequested
]

{ #category : #completion }
GtCompleter >> completeAsyncDo: aBlock in: aBlText at: anIndex [
	"Compute completion actions asyncronously and evaluate a given Block when the computation is finished"
	<return: #TAsyncPromise>

	^ completerMonitor critical: [
		| aNewCommand | 
		completerPromise ifNotNil: [ :anExistingCommand | anExistingCommand cancelSoft ].
		completerPromise := nil.
	
		completerPromise := aNewCommand := [ self complete: aBlText at: anIndex ] asAsyncFuture await: (AsyncFutureExecutionConfiguration new customGroup: #Completer; lowPriority).
		completerPromise then: [ :aResult |
				completerMonitor critical: [ completerPromise := nil. ].
				aBlock value: aResult ]
			otherwise: [ :anError |
				| errorSignalerContext |
				(anError signalContext notNil and: [
					(errorSignalerContext := anError signalerContext) notNil ])
						ifTrue: [
							NonInteractiveTranscript stdout
								nextPutAll: '[';
								nextPutAll: errorSignalerContext blocDefiningMethod printString;
								nextPutAll: '] '
							]
						ifFalse: [
							NonInteractiveTranscript stdout
								nextPutAll: '[<cannot retrieve method>]'
							].
					
				NonInteractiveTranscript stdout
					print: anError;
					nextPutAll: ' <';
					nextPutAll: 'logged in GtCompleter>>#completeAsyncDo:in:at:';
					nextPutAll: '>';
					cr;
					flush.	
			completerMonitor critical: [ completerPromise := nil ].
			aBlock value: GtCompletionResult empty ].
		aNewCommand ]
]

{ #category : #accessing }
GtCompleter >> defaultStrategy [
	<return: #GtCompletionStrategy>
	
	^ defaultStrategy
]

{ #category : #accessing }
GtCompleter >> defaultStrategy: aGtCompletionStrategy [
	defaultStrategy := aGtCompletionStrategy
]

{ #category : #initialization }
GtCompleter >> initialize [
	super initialize.
	
	defaultStrategy := GtStreamedCompletionStrategy new.
	showRequested := false.
	completerMonitor := Mutex new
]

{ #category : #accessing }
GtCompleter >> showRequested [
	^ showRequested
]

{ #category : #accessing }
GtCompleter >> showRequested: aBoolean [
	showRequested := aBoolean
]

{ #category : #accessing }
GtCompleter >> strategyAt: anIndex in: aBlText [
	"Choose a completion strategy for a given text index within a text"
	| aStrategy |
	
	aStrategy := self defaultStrategy.
	
	(aBlText attributesAt: anIndex)
		do: [ :eachAttribute |
			(eachAttribute isKindOf: GtCompletionStrategyAttribute)
				ifTrue: [ aStrategy := eachAttribute strategy ] ].
	^ aStrategy
]
