private
privateWeightedDo: aBlock withPrefix: aString
	| weighted maxWeighted |
	weighted := Heap sortBlock: [ :a :b | a first weight > b first weight or: [ a first weight = b first weight and: [ a last < b last ] ] ].
	maxWeighted := Heap sortBlock: [ :a :b | a first maxWeight > b first maxWeight or: [ a first weight = b first weight and: [ a last < b last ] ] ].
	self
		nodeFor: aString
		startingAt: 1
		do: [ :node :nodePrefix | 
			maxWeighted
				add:
					{node.
					(nodePrefix , node prefix)} ].
	[ [ maxWeighted notEmpty and: [ weighted isEmpty or: [ weighted first first weight < maxWeighted first first maxWeight ] ] ]
		whileTrue: [ | entry |
			entry := maxWeighted removeFirst.
			entry first weight > 0
				ifTrue: [ weighted add: entry ].
			entry first
				childrenDo: [ :each | 
					maxWeighted
						add:
							{each.
							(entry last , each prefix)} ] ].
	weighted notEmpty ]
		whileTrue: [ | item |
			item := weighted removeFirst.
			aBlock cull: item last cull: item first weight ]