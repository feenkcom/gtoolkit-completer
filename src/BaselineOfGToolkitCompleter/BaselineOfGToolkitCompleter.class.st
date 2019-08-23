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
				spec repository: 'github://j-brant/SmaCC:c78b7b307cadd205e6ea9cfc6dc351631599b98d/src' ];
			baseline: 'Brick' with: [
				spec repository: 'github://feenkcom/Brick:v0.7.45/src' ];
			baseline: 'GToolkitUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.7.0/src' ].
		spec 
			package: 'GToolkit-Completer-Pharo-Parser' with: [
				spec requires: #('SmaCC' ). ];
			package: 'GToolkit-Completer' with: [
				spec requires: #('Brick' 'SmaCC' 'GToolkit-Completer-Pharo-Parser' 'GToolkitUtility' ). ]. ].

]
