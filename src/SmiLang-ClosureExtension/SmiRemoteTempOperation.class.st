"
I represent operation on remoteTemps. A remote temp is a temp from one of the enclosing environment of a closure activation. 

contextIndex <Smi> distance of enclosing environment where the temp is from current activation.
"
Class {
	#name : #SmiRemoteTempOperation,
	#superclass : #SmiTempOperation,
	#instVars : [
		'contextIndex'
	],
	#category : #'SmiLang-ClosureExtension-compiler'
}

{ #category : #accessing }
SmiRemoteTempOperation >> contextIndex [
	^ contextIndex
]

{ #category : #accessing }
SmiRemoteTempOperation >> contextIndex: anObject [
	contextIndex := anObject
]
