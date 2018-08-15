comparing
= anObject
	^ super = anObject and: [ self from = anObject from and: [ self to = anObject to ] ]