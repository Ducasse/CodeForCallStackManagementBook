"
Executing this instruction creates a temp vector, represented by a Pharo array in the implemented interpreter, and pushes it on stack. As the temp vector holds temporary variables values, it needs to be initialized with 0 (in SmiLang all the temporaries are initialized with 0). The instruction holds the size of the temp vector to create.

"
Class {
	#name : #SmiCreateTempVector,
	#superclass : #SmiInstruction,
	#instVars : [
		'vectorSize'
	],
	#category : #'SmiLang-StackClosureExtension-compiler'
}

{ #category : #visitor }
SmiCreateTempVector >> accept: visitor [
	^ visitor visitCreateTempVector: self
]

{ #category : #printing }
SmiCreateTempVector >> printOn: s [
	s << 'createTempVector of size '.
	vectorSize printOn: s
]

{ #category : #accessing }
SmiCreateTempVector >> vectorSize [
	^ vectorSize
]

{ #category : #accessing }
SmiCreateTempVector >> vectorSize: anObject [
	vectorSize := anObject
]
