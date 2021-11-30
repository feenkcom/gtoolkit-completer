Extension { #name : #BlTktWorkerProvider }

{ #category : #'*GToolkit-Completer' }
BlTktWorkerProvider class >> completionPool [

	^ self 
		serviceNamed: self completionPoolName 
		ifMissing: [ self new completionPool; service ]
]

{ #category : #'*GToolkit-Completer' }
BlTktWorkerProvider >> completionPool [
	"Completion processing: maxPoolSize: 2, priority: 25"
	self
		name: self class completionPoolName;
		priorityQueue;
		poolMaxSize: 2;
		processPriority: Processor userBackgroundPriority - 5
]

{ #category : #'*GToolkit-Completer' }
BlTktWorkerProvider class >> completionPoolName [

	^ 'Completion'
]
