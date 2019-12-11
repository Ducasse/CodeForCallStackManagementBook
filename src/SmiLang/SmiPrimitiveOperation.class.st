"
This instruction represents a primitive operation between Smis (for example, +). Executing this instruction pops the two operands from the stack and pushes the result of the primitive operation.
"
Class {
	#name : #SmiPrimitiveOperation,
	#superclass : #SmiInstruction,
	#instVars : [
		'selector'
	],
	#category : #'SmiLang-compiler'
}

{ #category : #'as yet unclassified' }
SmiPrimitiveOperation >> accept: visitor [
	^ visitor visitPrimitiveOperation: self
]

{ #category : #printing }
SmiPrimitiveOperation >> printOn: s [
	s << 'primitive: ' << selector
]

{ #category : #accessing }
SmiPrimitiveOperation >> selector [
	^ selector
]

{ #category : #accessing }
SmiPrimitiveOperation >> selector: anObject [
	selector := anObject
]
