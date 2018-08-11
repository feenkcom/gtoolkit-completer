private
keywordsAndArgumentNamesDo: aBlock
	(text substrings: ':') do: [ :each | aBlock value: each , ':' value: '_' ]