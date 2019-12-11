"
Interprets SmiFunction using contexts.

	currentContext <SmiContext> Context being executed
"
Class {
	#name : #SmiContextInterpreter,
	#superclass : #Object,
	#instVars : [
		'currentContext'
	],
	#category : #'SmiLang-context interpreter'
}

{ #category : #private }
SmiContextInterpreter >> initialContext [
	^ SmiContext new
		programCounter: 0;
		function: #stopFlag;
		initialContext;
		yourself
]

{ #category : #private }
SmiContextInterpreter >> interpret [
	[ currentContext function == #stopFlag ] whileFalse: [ 
		currentContext programCounter: currentContext programCounter + 1. 
		self interpretNextInstruction ]
]

{ #category : #public }
SmiContextInterpreter >> interpret: function [
	currentContext := self initialContext.
	self newContextFor: function.
	self interpret.
	^ currentContext top
]

{ #category : #private }
SmiContextInterpreter >> interpretNextInstruction [
	"should ask the current instruction to 'accept: self' to dispatch"
	self shouldBeImplemented.
	
	Halt onCount: 1000. "You may use this code to halt on infinite loops"
]

{ #category : #private }
SmiContextInterpreter >> newContextFor: function [	
	currentContext := SmiContext new.
	
	"should set up a new currentContext:
	sender
	function
	programCounter
	stack and stackPointer
	arguments and temporaries"
	
	self shouldBeImplemented.
]

{ #category : #visiting }
SmiContextInterpreter >> visitCallFunction: node [
	"should call newContextFor:"
	self shouldBeImplemented.
]

{ #category : #visiting }
SmiContextInterpreter >> visitPop: node [
	self shouldBeImplemented.
]

{ #category : #visiting }
SmiContextInterpreter >> visitPrimitiveOperation: node [
	"Use perform:with: to get the primitive result"
	self shouldBeImplemented.
]

{ #category : #visiting }
SmiContextInterpreter >> visitPushSmi: node [
	self shouldBeImplemented.
]

{ #category : #visiting }
SmiContextInterpreter >> visitPushTemp: node [
	"Fetches the value from the stack based on node tempIndex"
	self shouldBeImplemented.
]

{ #category : #visiting }
SmiContextInterpreter >> visitReturnTop: node [
	"Push the top of the stack on the currentContext sender stack
	and resume execution in the sender."
	self shouldBeImplemented.
]

{ #category : #visiting }
SmiContextInterpreter >> visitStoreTemp: node [
	"There should be a location on stack to store this value"
	self shouldBeImplemented.
]
