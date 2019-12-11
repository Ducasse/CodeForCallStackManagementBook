"
I represent a closure in a suitable form for the stack interpreter.

function <SmiFunction> function I wrap
outerFrameWrapper <SmiStackFrameWrapper> indirect reference to my outer stack frame
tempVectorOrNil <nil | Array> nil if no temp vector needed for this closure. Else the temp vector.
"
Class {
	#name : #SmiVectorClosure,
	#superclass : #Object,
	#instVars : [
		'function',
		'outerFrameWrapper',
		'tempVectorOrNil'
	],
	#category : #'SmiLang-StackClosureExtension-stack interpreter'
}

{ #category : #accessing }
SmiVectorClosure >> function [
	^ function
]

{ #category : #accessing }
SmiVectorClosure >> function: anObject [
	function := anObject
]

{ #category : #accessing }
SmiVectorClosure >> outerFrameWrapper [
	^ outerFrameWrapper
]

{ #category : #accessing }
SmiVectorClosure >> outerFrameWrapper: anObject [
	outerFrameWrapper := anObject
]

{ #category : #accessing }
SmiVectorClosure >> tempVector [
	^ tempVectorOrNil
]

{ #category : #accessing }
SmiVectorClosure >> tempVector: tv [
	tempVectorOrNil := tv
]

{ #category : #accessing }
SmiVectorClosure >> tempVectorOrNil [
	^ tempVectorOrNil
]

{ #category : #accessing }
SmiVectorClosure >> tempVectorOrNil: anObject [
	tempVectorOrNil := anObject
]
