"
Same as pushVectorTemp instruction but mutates the temp vector instead of pushing a value on stack.
"
Class {
	#name : #SmiStoreVectorTemp,
	#superclass : #SmiVectorTempOperation,
	#category : #'SmiLang-StackClosureExtension-compiler'
}

{ #category : #'as yet unclassified' }
SmiStoreVectorTemp >> accept: visitor [
	^ visitor visitStoreVectorTemp: self
]

{ #category : #'as yet unclassified' }
SmiStoreVectorTemp >> prefix [
	^ 'store'
]
