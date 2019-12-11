Class {
	#name : #SmiStackInterpreterWithMultipleStackPagesCorrection,
	#superclass : #SmiStackInterpreterCorrection,
	#instVars : [
		'stackPages',
		'indexOfCurrentStackPage'
	],
	#category : #'SmiLang-Correction'
}

{ #category : #private }
SmiStackInterpreterWithMultipleStackPagesCorrection >> activateFunction: func [
	stackPointer + func stackSize + 3 <= currentStackPage size ifFalse: [ 
		self switchStackPage: func ].
	^ super activateFunction: func
]

{ #category : #initialization }
SmiStackInterpreterWithMultipleStackPagesCorrection >> initialize [

	super initialize.
 
	stackPages := { Array new: 10 . Array new: 10 }.
	indexOfCurrentStackPage := 1.
	currentStackPage := stackPages at: indexOfCurrentStackPage
]

{ #category : #private }
SmiStackInterpreterWithMultipleStackPagesCorrection >> switchStackPage: func [
	| arguments oldStackPointer |
	arguments := Array new: func numArguments.
	1 to: arguments size do: [ :i |
		arguments at: arguments size - i + 1 put: self pop ].
	currentStackPage := stackPages at: (indexOfCurrentStackPage := indexOfCurrentStackPage + 1). 
	oldStackPointer := stackPointer.
	stackPointer := 0.
	self push: oldStackPointer.
	programCounter := programCounter negated.
	arguments do: [ :arg | self push: arg ] 
]

{ #category : #visiting }
SmiStackInterpreterWithMultipleStackPagesCorrection >> visitReturnTop: node [
	| retValue |
	super visitReturnTop: node.
	programCounter < 0 ifFalse: [ ^ self ].
	"stack page switch"
	retValue := self pop.
	stackPointer := self pop.
	programCounter := programCounter negated.
	currentStackPage := stackPages at: (indexOfCurrentStackPage := indexOfCurrentStackPage - 1).
	self push: retValue
]
