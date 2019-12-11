"
This instruction represents a closure creation. Executing this instruction creates a new closure and pushes it on top of the stack. The closure is created with the anonymous function of the instruction and the context that created the closure (the active context at closure creation time). 
"
Class {
	#name : #SmiCreateClosure,
	#superclass : #SmiInstruction,
	#instVars : [
		'function'
	],
	#category : #'SmiLang-ClosureExtension-compiler'
}

{ #category : #visiting }
SmiCreateClosure >> accept: visitor [
	^ visitor visitCreateClosure: self
]

{ #category : #accessing }
SmiCreateClosure >> function [
	^ function
]

{ #category : #accessing }
SmiCreateClosure >> function: anObject [
	function := anObject
]

{ #category : #printing }
SmiCreateClosure >> printOn: s [
	s << 'createClosure'
]
