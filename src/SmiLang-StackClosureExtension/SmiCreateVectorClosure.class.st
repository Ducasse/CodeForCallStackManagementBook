"
This instruction represents a closure creation. Executing this instruction creates a new closure and pushes the value on top of the stack. The closure is created with the anonymous function of the instruction and the context that created the closure (the active context at closure creation time). 

In addition, this instruction requires the interpreter to store a reference to the temp vector in the closure. The temp vector holds the remote temporaries. The temp vector to store can be found in the current stack frame, it is accessed as a  temporary variable using the tempVectorIndex precised in this instruction. If no tempVectorIndex is specified (tempVectorIndex = nil), then the closure does not need any temp vector.
"
Class {
	#name : #SmiCreateVectorClosure,
	#superclass : #SmiCreateClosure,
	#instVars : [
		'tempVectorIndex'
	],
	#category : #'SmiLang-StackClosureExtension-compiler'
}

{ #category : #visitor }
SmiCreateVectorClosure >> accept: visitor [
	^ visitor visitCreateVectorClosure: self
]

{ #category : #printing }
SmiCreateVectorClosure >> printOn: s [
	s << 'createClosureWithVectorAt: '.
	tempVectorIndex printOn: s
]

{ #category : #accessing }
SmiCreateVectorClosure >> tempVectorIndex [
	^ tempVectorIndex
]

{ #category : #accessing }
SmiCreateVectorClosure >> tempVectorIndex: anObject [
	tempVectorIndex := anObject
]
