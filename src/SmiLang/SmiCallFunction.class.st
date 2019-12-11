"
This instruction represents a static call. The instruction has a reference to the function to call. Executing the instruction activates the function.
"
Class {
	#name : #SmiCallFunction,
	#superclass : #SmiInstruction,
	#instVars : [
		'function'
	],
	#category : #'SmiLang-compiler'
}

{ #category : #'as yet unclassified' }
SmiCallFunction >> accept: visitor [
	^ visitor visitCallFunction: self
]

{ #category : #accessing }
SmiCallFunction >> function [
	^ function
]

{ #category : #accessing }
SmiCallFunction >> function: anObject [
	function := anObject
]

{ #category : #printing }
SmiCallFunction >> printOn: s [
	s << 'call ' << function funcName
]
