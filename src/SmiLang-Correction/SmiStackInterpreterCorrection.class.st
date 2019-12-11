Class {
	#name : #SmiStackInterpreterCorrection,
	#superclass : #Object,
	#instVars : [
		'programCounter',
		'currentFunction',
		'framePointer',
		'stackPointer',
		'currentStackPage'
	],
	#category : #'SmiLang-Correction'
}

{ #category : #private }
SmiStackInterpreterCorrection >> activateFunction: func [
	self push: programCounter.
	self push: currentFunction.
	self push: framePointer.
	framePointer := stackPointer.
	
	currentFunction := func.
	programCounter := 0.
	currentFunction numTemps timesRepeat: [ self push: 0 ]
]

{ #category : #initialization }
SmiStackInterpreterCorrection >> initialize [

	super initialize.

	currentStackPage := Array new: 1000.
	stackPointer := 0.
]

{ #category : #initialization }
SmiStackInterpreterCorrection >> initializeStackFor: function [
	programCounter := 99.
	currentFunction := #functionFlag.
	framePointer := #framePointerFlag.
	self activateFunction: function
]

{ #category : #private }
SmiStackInterpreterCorrection >> interpret [
	[ currentFunction == #functionFlag ] whileFalse: [ 
		programCounter := programCounter + 1. 
		self interpretNextInstruction ]
]

{ #category : #public }
SmiStackInterpreterCorrection >> interpret: function [
	self initializeStackFor: function.
	self interpret.
	^ currentStackPage first
]

{ #category : #private }
SmiStackInterpreterCorrection >> interpretNextInstruction [
	(currentFunction instructionAt: programCounter) accept: self
]

{ #category : #stack }
SmiStackInterpreterCorrection >> pop [
	| val |
	val := currentStackPage at: stackPointer.
	stackPointer := stackPointer - 1.
	^ val
]

{ #category : #stack }
SmiStackInterpreterCorrection >> push: elem [ 
	currentStackPage at: (stackPointer := stackPointer + 1) put: elem
]

{ #category : #visiting }
SmiStackInterpreterCorrection >> pushArgument: index [
	self push: (currentStackPage at: framePointer - 3 - currentFunction numArguments + index)
]

{ #category : #visiting }
SmiStackInterpreterCorrection >> pushLocalTemp: index [
	self push: (currentStackPage at: framePointer + (self temporaryFrameOffset: index))
]

{ #category : #private }
SmiStackInterpreterCorrection >> return: value [
	stackPointer := framePointer - 3 - currentFunction numArguments.
	currentFunction := currentStackPage at: framePointer - 1.
	programCounter := currentStackPage at: framePointer - 2.
	framePointer := currentStackPage at: framePointer.
	self push: value

]

{ #category : #private }
SmiStackInterpreterCorrection >> temporaryFrameOffset: index [
	^ index - currentFunction numArguments
]

{ #category : #stack }
SmiStackInterpreterCorrection >> top [
	^ currentStackPage at: stackPointer
]

{ #category : #visiting }
SmiStackInterpreterCorrection >> visitCallFunction: node [
	self activateFunction: node function
]

{ #category : #visiting }
SmiStackInterpreterCorrection >> visitPop: node [
	stackPointer := stackPointer - 1
]

{ #category : #visiting }
SmiStackInterpreterCorrection >> visitPrimitiveOperation: node [
	| rcvr arg |
	arg := self pop.
	rcvr := self pop.
	self push: (rcvr perform: node selector with: arg)
]

{ #category : #visiting }
SmiStackInterpreterCorrection >> visitPushSmi: node [
	self push: node smi
]

{ #category : #visiting }
SmiStackInterpreterCorrection >> visitPushTemp: node [
	node tempIndex > currentFunction numArguments
		ifTrue: [ self pushLocalTemp: node tempIndex ]
		ifFalse: [  self pushArgument: node tempIndex ]
]

{ #category : #visiting }
SmiStackInterpreterCorrection >> visitReturnTop: node [
	self return: self top
]

{ #category : #visiting }
SmiStackInterpreterCorrection >> visitStoreTemp: node [
	currentStackPage at: framePointer + (self temporaryFrameOffset: node tempIndex) put: self top
]
