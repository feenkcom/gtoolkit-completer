Class {
	#name : #BaselineOfGToolkitCompleter,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitCompleter
}

{ #category : #baseline }
BaselineOfGToolkitCompleter >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'SmaCC' with: [
				spec repository: 'github://j-brant/SmaCC:1a012d607875c0a756e6e21a4b7ed63bedf22159/src' ];
			baseline: 'Brick' with: [
				spec repository: 'github://feenkcom/Brick:v0.8.284/src' ];
			baseline: 'GToolkitUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.26/src' ].
		spec 
			package: 'GToolkit-Completer-Pharo-Parser' with: [
				spec requires: #('SmaCC' ). ];
			package: 'GToolkit-Completer' with: [
				spec requires: #('Brick' 'SmaCC' 'GToolkit-Completer-Pharo-Parser' 'GToolkitUtility' ). ]. ].

]
