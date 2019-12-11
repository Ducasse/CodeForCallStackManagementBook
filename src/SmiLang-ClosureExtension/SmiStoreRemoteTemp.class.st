"
Basically this instruction is the same as the PushRemoteTemp instruction with a store instead of a push.
"
Class {
	#name : #SmiStoreRemoteTemp,
	#superclass : #SmiRemoteTempOperation,
	#category : #'SmiLang-ClosureExtension-compiler'
}

{ #category : #visitor }
SmiStoreRemoteTemp >> accept: visitor [
	^ visitor visitStoreRemoteTemp: self
]

{ #category : #printing }
SmiStoreRemoteTemp >> printOn: s [
	s << 'storeRemoteTemp: ' << tempIndex printString << ' inOuter: ' << contextIndex printString
]
