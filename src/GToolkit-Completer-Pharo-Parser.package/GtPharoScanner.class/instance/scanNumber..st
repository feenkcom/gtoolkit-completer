scanning
scanNumber: anInteger
	| end |
	matchActions := Array with: anInteger.
	[ Number readFrom: stream ]
		on: Error
		do: [ :ex | matchActions := #(0) ].
	outputStream reset.
	end := stream position.
	stream position: start.
	^ self createTokenFor: (stream next: end - start)