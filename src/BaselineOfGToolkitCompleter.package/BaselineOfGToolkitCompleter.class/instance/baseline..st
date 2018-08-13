baseline
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ 
			spec 
				baseline: 'SmaCC' with: [ 
					spec repository: 'github://j-brant/SmaCC/src' ];
				baseline: 'Brick' with: [ 
					spec 
						repository: 'github://pharo-graphics/Brick/src';
						loads: #core ];
				package: 'GToolkit-Completer' with: [ 
					spec requires: #( 
						'Brick'
						'SmaCC'
						'GToolkit-Completer-Pharo-Parser' ) ];
				package: 'GToolkit-Completer-Pharo-Parser' with: [ 
					spec requires: #( 'Smacc' ) ] ]