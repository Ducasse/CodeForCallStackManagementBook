"
Executing this instruction pushes the top of stack on the context's sender or stack frame caller. Pursuing the execution resumes the execution in the calling function.
"
Class {
	#name : #SmiReturnTop,
	#superclass : #SmiInstruction,
	#category : #'SmiLang-compiler'
}

{ #category : #'as yet unclassified' }
SmiReturnTop >> accept: visitor [
	^ visitor visitReturnTop: self
]

{ #category : #printing }
SmiReturnTop >> printOn: s [
	s << 'returnTop'
]
