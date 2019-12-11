Class {
	#name : #SmiContextInterpreterCorrection,
	#superclass : #Object,
	#instVars : [
		'currentContext'
	],
	#category : #'SmiLang-Correction'
}

{ #category : #private }
SmiContextInterpreterCorrection >> initialContext [
	^ SmiContext new
		programCounter: 0;
		function: #stopFlag;
		initialContext;
		yourself
]

{ #category : #private }
SmiContextInterpreterCorrection >> interpret [
	[ currentContext function == #stopFlag ] whileFalse: [ 
		currentContext programCounter: currentContext programCounter + 1. 
		self interpretNextInstruction ]
]

{ #category : #public }
SmiContextInterpreterCorrection >> interpret: function [
	currentContext := self initialContext.
	self newContextFor: function.
	self interpret.
	^ currentContext top
]

{ #category : #private }
SmiContextInterpreterCorrection >> interpretNextInstruction [
	(currentContext function instructionAt: currentContext programCounter) accept: self
]

{ #category : #private }
SmiContextInterpreterCorrection >> newContextFor: function [	
	self newContextFor: function contextClass: SmiContext
]

{ #category : #private }
SmiContextInterpreterCorrection >> newContextFor: function	contextClass: class [
	| nextContext arguments |
	nextContext := class new.
	nextContext
		programCounter: 0;
		sender: currentContext;
		initializeWithFunc: function.
	arguments := Array new: function numArguments.
	1 to: arguments size do: [ :i |
		arguments at: arguments size - i + 1 put: currentContext pop ].
	currentContext := nextContext.
	arguments do: [ :arg |
		currentContext push: arg ].
	function numTemps timesRepeat: [ currentContext push: 0 ].
]

{ #category : #visiting }
SmiContextInterpreterCorrection >> visitCallFunction: node [
	self newContextFor: node function	
]

{ #category : #visiting }
SmiContextInterpreterCorrection >> visitPop: node [
	currentContext pop
]

{ #category : #visiting }
SmiContextInterpreterCorrection >> visitPrimitiveOperation: node [
	| rcvr arg |
	arg := currentContext pop.
	rcvr := currentContext pop.
	currentContext push: (rcvr perform: node selector with: arg)
]

{ #category : #visiting }
SmiContextInterpreterCorrection >> visitPushSmi: node [
	currentContext push: node smi
]

{ #category : #visiting }
SmiContextInterpreterCorrection >> visitPushTemp: node [
	currentContext push: (currentContext stackAt: node tempIndex)
]

{ #category : #visiting }
SmiContextInterpreterCorrection >> visitReturnTop: node [
	| retValue |
	retValue := currentContext top.
	currentContext := currentContext sender.
	currentContext push: retValue
]

{ #category : #visiting }
SmiContextInterpreterCorrection >> visitStoreTemp: node [
	currentContext stackAt: node tempIndex put: currentContext top.
]
