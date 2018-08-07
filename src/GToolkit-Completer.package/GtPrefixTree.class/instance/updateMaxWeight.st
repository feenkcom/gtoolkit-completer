private
updateMaxWeight
	maxWeight := weight.
	self childrenDo: [ :each | maxWeight := maxWeight max: each maxWeight ]