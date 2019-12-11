"
Executing this instruction pops the top of the stack.
"
Class {
	#name : #SmiPop,
	#superclass : #SmiInstruction,
	#category : #'SmiLang-compiler'
}

{ #category : #'as yet unclassified' }
SmiPop >> accept: visitor [
	^ visitor visitPop: self
]

{ #category : #printing }
SmiPop >> printOn: s [
	s << 'pop'
]
