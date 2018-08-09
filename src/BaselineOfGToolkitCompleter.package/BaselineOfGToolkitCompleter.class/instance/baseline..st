baseline
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec package: 'GToolkit-Completer' with: [ spec requires: 'GToolkit-Completer-Pharo-Parser' ].
			spec package: 'GToolkit-Completer-Pharo-Parser' ]