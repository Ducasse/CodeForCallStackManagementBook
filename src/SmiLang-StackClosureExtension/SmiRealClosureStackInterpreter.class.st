"
Interprets using a theoretically infinite stack page the SmiFunctions.

In addition to my superclass I handle non local returns.
"
Class {
	#name : #SmiRealClosureStackInterpreter,
	#superclass : #SmiSimplifiedClosureStackInterpreter,
	#category : #'SmiLang-StackClosureExtension-stack interpreter'
}

{ #category : #visiting }
SmiRealClosureStackInterpreter >> visitCreateVectorClosure: instruction [
	 "In addition to the superclass, Closure creation requires the creation of a stackFrameWrapper for the current stack frame if it does not exist and assign it to the closure outerFrameWrapper field."
	self shouldBeImplemented
]

{ #category : #visiting }
SmiRealClosureStackInterpreter >> visitNonLocalReturnTop: nlr [ 
	"Walks up the stack to find the home stack frame. Each time an outerFrameWrapper is accessed, the interpreter needs to ensure that it still references a live frame or raise a BlockCannotReturn. Once the home frame is found and live, execution can return from that frame."
	self shouldBeImplemented 
]
