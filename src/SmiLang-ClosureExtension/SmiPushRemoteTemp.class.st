"
This instruction holds the index of the temporary variable to access but also the number of outer context that needs to be walked in the outer context chain in order to find the context that holds the temporary variable to push.

Executing this instruction searches first in the outer context chain the context to access (it looks for the nth outer context, n being precised in the instruction). Then it pushes on stack the temporary value at the index precised in the instruction from the nth outer context to the top of the active context’s stack.

"
Class {
	#name : #SmiPushRemoteTemp,
	#superclass : #SmiRemoteTempOperation,
	#category : #'SmiLang-ClosureExtension-compiler'
}

{ #category : #'as yet unclassified' }
SmiPushRemoteTemp >> accept: visitor [
	^ visitor visitPushRemoteTemp: self
]

{ #category : #printing }
SmiPushRemoteTemp >> printOn: s [
	s << 'pushRemoteTemp: ' << tempIndex printString << ' inOuter: ' << contextIndex printString
]
