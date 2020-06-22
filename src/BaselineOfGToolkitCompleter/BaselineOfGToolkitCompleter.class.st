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
				spec repository: 'github://j-brant/SmaCC:ceee94d6ebda57c884a26e21b60ed490e91d69e0/src' ];
			baseline: 'Brick' with: [
				spec repository: 'github://feenkcom/Brick:v0.7.532/src' ];
			baseline: 'GToolkitUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.7.35/src' ].
		spec 
			package: 'GToolkit-Completer-Pharo-Parser' with: [
				spec requires: #('SmaCC' ). ];
			package: 'GToolkit-Completer' with: [
				spec requires: #('Brick' 'SmaCC' 'GToolkit-Completer-Pharo-Parser' 'GToolkitUtility' ). ]. ].

]
