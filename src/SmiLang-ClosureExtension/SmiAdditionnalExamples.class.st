"
All the methods here cannot be executed in Smalltalk, they are SmiLang methods. Each method beginning by example is used in the SmiClosureTests to validate the interpreters' behavior.
"
Class {
	#name : #SmiAdditionnalExamples,
	#superclass : #Object,
	#instVars : [
		'call'
	],
	#category : #'SmiLang-ClosureExtension-tests'
}

{ #category : #'as yet unclassified' }
SmiAdditionnalExamples class >> exampleId [
	^ 2
]

{ #category : #calls }
SmiAdditionnalExamples >> activateClosure: closure [
	^ closure value
]

{ #category : #calls }
SmiAdditionnalExamples >> closureDeadOuter [
	| remoteTemp |
	remoteTemp := 1.
	^ [ remoteTemp ]
]

{ #category : #calls }
SmiAdditionnalExamples >> closureDeadOuter2 [
	^ [ ^ 6 ]
]

{ #category : #calls }
SmiAdditionnalExamples >> closureDeadOuter3 [
	| t |
	t := [ ^ 1 ].
	[ ^ t ] value.
	^ 5
]

{ #category : #tests }
SmiAdditionnalExamples >> example01Closure [
	^ [ 1 ]
]

{ #category : #tests }
SmiAdditionnalExamples >> example02ClosureActivation [
	| temp |
	temp := [ 1 ].
	^ temp value
]

{ #category : #tests }
SmiAdditionnalExamples >> example03ClosureTemp [
	^ [ | temp | temp := 1. temp + 1 ] value
]

{ #category : #tests }
SmiAdditionnalExamples >> example04ClosureRemoteTemp [
	| remoteTemp |
	remoteTemp := 1.
	^ [ remoteTemp ] value
]

{ #category : #tests }
SmiAdditionnalExamples >> example05ClosureRemoteTemp2 [
	| remoteTemp |
	remoteTemp := 1.
	^ [ remoteTemp := 2. remoteTemp + 1 ] value
]

{ #category : #tests }
SmiAdditionnalExamples >> example06ClosureRemoteTempDeadOuter [
	^ call closureDeadOuter value
]

{ #category : #tests }
SmiAdditionnalExamples >> example07ClosureNestedTemp [
	| remote11 remote12 |
	remote11 := 11.
	^ [ | remote21 |
		remote12 := [ remote21 := remote11 + 1. remote21 ] value.
		remote21 + remote12 ] value.
]

{ #category : #tests }
SmiAdditionnalExamples >> example08ClosureNLR [
	call activateClosure: [ ^ 5 ].
	^ 10
]

{ #category : #tests }
SmiAdditionnalExamples >> example09CannotReturn [
	^ call closureDeadOuter2 value
]

{ #category : #tests }
SmiAdditionnalExamples >> example10CannotReturn2 [
	^ call closureDeadOuter3 value
]
