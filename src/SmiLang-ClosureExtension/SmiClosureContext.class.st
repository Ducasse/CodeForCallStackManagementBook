"
I represent a closure activation. I need to hold a reference to the closure to access remote temporaries.
"
Class {
	#name : #SmiClosureContext,
	#superclass : #SmiContext,
	#instVars : [
		'closure'
	],
	#category : #'SmiLang-ClosureExtension-context interpreter'
}

{ #category : #accessing }
SmiClosureContext >> closure [
	^ closure
]

{ #category : #accessing }
SmiClosureContext >> closure: anObject [
	closure := anObject
]

{ #category : #accessing }
SmiClosureContext >> home [
	^ closure outerContext home
]
