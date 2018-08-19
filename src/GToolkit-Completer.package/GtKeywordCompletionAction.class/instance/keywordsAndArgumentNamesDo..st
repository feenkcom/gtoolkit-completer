private
keywordsAndArgumentNamesDo: aBlock
	text first = $:
		ifTrue: [ aBlock value: ':' value: '_' ].
	(text substrings: ':') do: [ :each | aBlock value: each , ':' value: '_' ]