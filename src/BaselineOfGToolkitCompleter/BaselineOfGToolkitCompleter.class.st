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
				spec repository: 'github://j-brant/SmaCC:95db996dc5c2f8e117e95792b34507fcb09a4584/src' ];
			baseline: 'Brick' with: [
				spec repository: 'github://feenkcom/Brick:v0.7.573/src' ];
			baseline: 'GToolkitUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.7.37/src' ].
		spec 
			package: 'GToolkit-Completer-Pharo-Parser' with: [
				spec requires: #('SmaCC' ). ];
			package: 'GToolkit-Completer' with: [
				spec requires: #('Brick' 'SmaCC' 'GToolkit-Completer-Pharo-Parser' 'GToolkitUtility' ). ]. ].

]
