"
Interprets using a theoretically infinite stack page the SmiFunctions.

In addition to my superclass I handle closure activation.

I am not able to handle non local returns, but I can handle remote temp access.
"
Class {
	#name : #SmiSimplifiedClosureStackInterpreter,
	#superclass : #SmiStackInterpreter,
	#category : #'SmiLang-StackClosureExtension-stack interpreter'
}

{ #category : #private }
SmiSimplifiedClosureStackInterpreter >> activateFunction: func [ 
	"This should be redefined somehow to add the space in the stack frame for the reference to the closure and the stackFrameWrapper if they exist."
		self shouldBeImplemented 
]

{ #category : #visiting }
SmiSimplifiedClosureStackInterpreter >> visitActivateClosure: node [
	"On top of stack is the closure to activate. If it's not a closure raise an exception."
	self shouldBeImplemented 
]

{ #category : #visiting }
SmiSimplifiedClosureStackInterpreter >> visitCreateTempVector: createTempVect [ 
	"Pushes on stack an Array of the size precised in the instruction. The array has to be initialized with 0 because it holds temp values"
	self shouldBeImplemented 
]

{ #category : #visiting }
SmiSimplifiedClosureStackInterpreter >> visitCreateVectorClosure: createClosure [
	"Creates a closure (SmiVectorClosure) and pushes it on stack. If a tempVectorIndex is specified in the instruction, the closure needs to hold it in its tempVectorOrNil field."
		self shouldBeImplemented 
]

{ #category : #visiting }
SmiSimplifiedClosureStackInterpreter >> visitNonLocalReturnTop: nlr [ 
	"unsupported"
	BlockCannotReturn signal
]

{ #category : #visiting }
SmiSimplifiedClosureStackInterpreter >> visitPushVectorTemp: vectorPush [
	"Pushes a remote temp on stack. The instruction holds the index of the tempVector on stack (a tempVector is stored as temporary variable) and the index of the temp in the tempVector"
	self shouldBeImplemented 
]

{ #category : #visiting }
SmiSimplifiedClosureStackInterpreter >> visitStoreVectorTemp: vectorStore [ 
	"Stores into a remote temp. The instruction holds the index of the tempVector on stack (a tempVector is stored as temporary variable) and the index of the temp in the tempVector"
	self shouldBeImplemented 
]
