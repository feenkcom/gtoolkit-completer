private
pauseForCompletion
	| semaphore |
	semaphore := Semaphore new.
	[ (Delay forMilliseconds: 50) wait.
	semaphore signal ] fork.
	semaphore wait