Class {
	#name : #BaselineOfGToolkitCompleter,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitCompleter
}

{ #category : #baseline }
BaselineOfGToolkitCompleter >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec baseline: 'Brick' with: [
				spec repository: 'github://feenkcom/Brick:main/src' ].
		spec package: 'GToolkit-Completer' with: [
				spec requires: #('Brick' ). ]. ].

]
