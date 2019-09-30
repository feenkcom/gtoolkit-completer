Class {
	#name : #BaselineOfGToolkitCompleter,
	#superclass : #BaselineOf,
	#category : 'BaselineOfGToolkitCompleter'
}

{ #category : #baseline }
BaselineOfGToolkitCompleter >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'SmaCC' with: [
				spec repository: 'github://j-brant/SmaCC:d5938dbd424bba257b1ffc17ee7b77796ecc4edc/src' ];
			baseline: 'Brick' with: [
				spec repository: 'github://feenkcom/Brick:v0.7.95/src' ];
			baseline: 'GToolkitUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.7.2/src' ].
		spec 
			package: 'GToolkit-Completer-Pharo-Parser' with: [
				spec requires: #('SmaCC' ). ];
			package: 'GToolkit-Completer' with: [
				spec requires: #('Brick' 'SmaCC' 'GToolkit-Completer-Pharo-Parser' 'GToolkitUtility' ). ]. ].

]
