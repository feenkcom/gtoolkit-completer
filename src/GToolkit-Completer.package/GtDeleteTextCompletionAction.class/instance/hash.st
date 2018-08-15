comparing
hash
	^ (super hash bitXor: self from hash) bitXor: self to hash