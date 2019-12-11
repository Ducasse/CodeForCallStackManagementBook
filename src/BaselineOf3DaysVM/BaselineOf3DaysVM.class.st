Class {
	#name : #BaselineOf3DaysVM,
	#superclass : #BaselineOf,
	#category : #BaselineOf3DaysVM
}

{ #category : #baselines }
BaselineOf3DaysVM >> baseline: spec [ 
   	<baseline>
        
	spec for: #common do: [
		spec package: 'SmiLang' .
		spec package: 'SmiLang-ClosureExtension' with: [
			spec requires: #('SmiLang') ].
		spec package: 'SmiLang-StackClosureExtension' with: [
			spec requires: #('SmiLang' 'SmiLang-ClosureExtension') ].
	].


]
