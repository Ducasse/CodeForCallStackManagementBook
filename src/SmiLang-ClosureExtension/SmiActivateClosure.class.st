"
Executing this instruction pops the closure on top of the stack and activates it. If there is something else than a closure on top of the stack, the interpreter raises an error and stop the execution of the program.

This operation is very similar to a function call as it creates a new context for the closure’s anonymous function. However, the closure activation context needs a reference to the closure in addition to all the information a regular context has. Hence, closure’s activations are represented as a separate data structure (in our case, a separate class) as they need an extra field.

"
Class {
	#name : #SmiActivateClosure,
	#superclass : #SmiInstruction,
	#category : #'SmiLang-ClosureExtension-compiler'
}

{ #category : #visitor }
SmiActivateClosure >> accept: visitor [
	^ visitor visitActivateClosure: self
]

{ #category : #printing }
SmiActivateClosure >> printOn: s [
	s << 'activateClosure'
]
