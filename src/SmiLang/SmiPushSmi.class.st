"
Executing this instruction pushes a Smi constant on top of the stack. The instruction has a direct reference to the Smi to push.
"
Class {
	#name : #SmiPushSmi,
	#superclass : #SmiInstruction,
	#instVars : [
		'smi'
	],
	#category : #'SmiLang-compiler'
}

{ #category : #'as yet unclassified' }
SmiPushSmi >> accept: visitor [
	^ visitor visitPushSmi: self
]

{ #category : #printing }
SmiPushSmi >> printOn: s [
	s << 'push ' << smi printString
]

{ #category : #accessing }
SmiPushSmi >> smi [
	^ smi
]

{ #category : #accessing }
SmiPushSmi >> smi: anObject [
	smi := anObject
]
