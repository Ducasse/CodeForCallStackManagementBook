"
Executing this instruction returns the execution to the closure’s home context sender instead of the active context sender. If the closure’s home context is already terminated, the interpreter raise a BlockCannotReturn exception. 

When performing a non local return, all the contexts in-between the closure activation and the closure’s home context sender need to be terminated. This way, other closures with other home context will always know if their home context is terminated or not. 

There are different ways to represent a terminated context. One possibility is to represent a terminated context as a context which pc is nilled out. This implies nilling out the pc field of the context upon return and nilling out the pc feld of several contexts in case of non local return.
"
Class {
	#name : #SmiNonLocalReturnTop,
	#superclass : #SmiInstruction,
	#category : #'SmiLang-ClosureExtension-compiler'
}

{ #category : #visitor }
SmiNonLocalReturnTop >> accept: visitor [
	^ visitor visitNonLocalReturnTop: self
]

{ #category : #printing }
SmiNonLocalReturnTop >> printOn: s [
	s << 'nonLocalReturnTop'
]
