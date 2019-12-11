"
This operation manages access to temporaries in a remote temp vector.

tempVectorIndex <Smi> index of the temp vector in the current activation's temporaries
"
Class {
	#name : #SmiVectorTempOperation,
	#superclass : #SmiTempOperation,
	#instVars : [
		'tempVectorIndex'
	],
	#category : #'SmiLang-StackClosureExtension-compiler'
}

{ #category : #printing }
SmiVectorTempOperation >> printOn: s [
	s << self prefix.
	s << 'Temp '.
	tempIndex printOn: s.
	s << ' in vector at '.
	tempVectorIndex printOn: s
]

{ #category : #accessing }
SmiVectorTempOperation >> tempVectorIndex [
	^ tempVectorIndex
]

{ #category : #accessing }
SmiVectorTempOperation >> tempVectorIndex: anObject [
	tempVectorIndex := anObject
]
