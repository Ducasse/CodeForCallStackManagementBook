"
Executing this instruction pushes the value of a temporary variable on top of the stack. The instruction has a reference to the index of the temporary variable to push. This operation is typically used when the program needs to read the value of a temporary variable.
"
Class {
	#name : #SmiPushTemp,
	#superclass : #SmiTempOperation,
	#category : #'SmiLang-compiler'
}

{ #category : #'as yet unclassified' }
SmiPushTemp >> accept: visitor [
	^ visitor visitPushTemp: self
]

{ #category : #printing }
SmiPushTemp >> printOn: s [
	s << 'pushTemp: ' << tempIndex printString
]
