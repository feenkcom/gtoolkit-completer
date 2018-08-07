accessing
size
	| count |
	count := 0.
	self do: [ :each | count := count + 1 ].
	^ count