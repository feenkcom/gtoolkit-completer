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
		'completerCommand',
		'completerMonitor',
		'maxCompletionItems'
	],
	#category : 'GToolkit-Completer-Model'
}

{ #category : #completion }
GtCompleter >> complete: aBlText at: anIndex [
	"Compute completion actions syncronously for a given text and an index"
	<return: #Collection of: #GtCompletionAction>

	^ (self strategyAt: anIndex in: aBlText)
		completionActionsFor: aBlText
		at: anIndex
		max: self maxCompletionItems
		requested: showRequested
]

{ #category : #completion }
GtCompleter >> completeAsyncDo: aBlock in: aBlText at: anIndex [
	"Compute completion actions asyncronously and evaluate a given Block when the computation is finished"	
		
	completerMonitor critical: [
		| completerCommandBlock aCommand |
		self terminateCompleterCommand.

		completerCommandBlock := [
			| theActions |
			theActions := [ self complete: aBlText at: anIndex ] on: Error do: [ :anError |
				anError emit.
						
				NonInteractiveTranscript stdout
					nextPutAll: '[';
					nextPutAll: anError signalerContext blocDefiningMethod printString;
					nextPutAll: '] ';
					print: anError;
					cr;
					flush.
				anError return: #() ].
			aBlock value: theActions.
			
			completerMonitor critical: [
				completerCommand == aCommand
					ifTrue: [ completerCommand := nil ] ] ].

		completerCommand := aCommand := completerCommandBlock asBlTktTerminableCommand asBlTktLoggingCommand.
		
		BlUseAsyncFeatures 
			ifEnabledDo: [ BlTktWorkerProvider completionPool schedule: completerCommand ]
			otherwise: [ completerCommand execute ] ]
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
	
	defaultStrategy := GtCompletionStrategy new.
	maxCompletionItems := 10.
	showRequested := false.
	completerMonitor := Monitor new
]

{ #category : #accessing }
GtCompleter >> maxCompletionItems [
	<return: #Number>
	
	^ maxCompletionItems
]

{ #category : #accessing }
GtCompleter >> maxCompletionItems: aNumber [
	maxCompletionItems := aNumber
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

{ #category : #accessing }
GtCompleter >> terminateCompleterCommand [
	completerMonitor critical: [
		completerCommand ifNotNil: [ :aCommand | aCommand terminate ].
		completerCommand := nil ]
]
