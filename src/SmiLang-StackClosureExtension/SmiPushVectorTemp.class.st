"
This instruction holds two indexes: the index of the temp vector and the index of the temporary variable in the temp vector. Executing this instruction is done in 2 steps. Firstly, the interpreter fetches the temp vector. It is can be accessed in the stack frame as a temporary variable using as index tempVectorIndex (precised by this instruction). Then it can push on stack the value available in the temp vector at the correct index, precised in tthis instruction (tempIndex).
"
Class {
	#name : #SmiPushVectorTemp,
	#superclass : #SmiVectorTempOperation,
	#category : #'SmiLang-StackClosureExtension-compiler'
}

{ #category : #'as yet unclassified' }
SmiPushVectorTemp >> accept: visitor [
	^ visitor visitPushVectorTemp: self
]

{ #category : #'as yet unclassified' }
SmiPushVectorTemp >> prefix [
	^ 'push'
]
