comparing
hash
	^ super hash bitXor: (text hash bitXor: position hash)