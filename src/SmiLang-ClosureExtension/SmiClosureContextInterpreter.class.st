"
I am an extension of the SmiContextInterpreter that can interpret closures in addition to the superclass behavior.
"
Class {
	#name : #SmiClosureContextInterpreter,
	#superclass : #SmiContextInterpreter,
	#category : #'SmiLang-ClosureExtension-context interpreter'
}

{ #category : #visiting }
SmiClosureContextInterpreter >> visitActivateClosure: node [
	"On top of stack is the closure to activate."
	self shouldBeImplemented
]

{ #category : #visiting }
SmiClosureContextInterpreter >> visitCreateClosure: createClosure [
	"Should push on stack a new closure (instance of SmiClosure)"
	self shouldBeImplemented.
]

{ #category : #visiting }
SmiClosureContextInterpreter >> visitNonLocalReturnTop: nlr [
	"If the closure's home context is dead, should raise a BlockCannotReturn exception.
	Else, terminates all the context from the active context to the home, and returns the 
	value on top of stack to the home's sender"
	self shouldBeImplemented
]

{ #category : #visiting }
SmiClosureContextInterpreter >> visitPushRemoteTemp: remoteTempAccess [
	"Pushes on stack the temporary variable of an outer context. "
	self shouldBeImplemented
]

{ #category : #visiting }
SmiClosureContextInterpreter >> visitStoreRemoteTemp: remoteTempAccess [
	"store into a temporary variable of an outer context. "
	self shouldBeImplemented
]
