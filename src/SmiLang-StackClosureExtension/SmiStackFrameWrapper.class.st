"
Indirect reference to a stack frame.

	stackFrameIndex <Smi> index of the frame pointer of the frame I wrap. May be invalid if the frame has returned.
"
Class {
	#name : #SmiStackFrameWrapper,
	#superclass : #Object,
	#instVars : [
		'stackFrameIndex'
	],
	#category : #'SmiLang-StackClosureExtension-stack interpreter'
}

{ #category : #accessing }
SmiStackFrameWrapper >> stackFrameIndex [
	^ stackFrameIndex
]

{ #category : #accessing }
SmiStackFrameWrapper >> stackFrameIndex: anObject [
	stackFrameIndex := anObject
]
