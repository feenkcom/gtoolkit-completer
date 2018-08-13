private
annotationRegex
	^ '(\$\{([^$:|}]*))(([:|](([-a-zA-Z0-9]+=)?[^|}]+)*)*)(}?\$?)' asRegex