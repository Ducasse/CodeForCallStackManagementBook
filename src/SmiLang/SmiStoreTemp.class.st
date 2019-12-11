"
Executing this instruction changes the value of a temporary variable for the value present on top of the stack. The instruction has a reference to the index of the temporary variable to push.  This operation is typically used when the program needs to write the value of a temporary variable.
"
Class {
	#name : #SmiStoreTemp,
	#superclass : #SmiTempOperation,
	#category : #'SmiLang-compiler'
}

{ #category : #'as yet unclassified' }
SmiStoreTemp >> accept: visitor [
	^ visitor visitStoreTemp: self
]

{ #category : #printing }
SmiStoreTemp >> printOn: s [
	s << 'storeTemp: ' << tempIndex printString
]
