"
Interprets using a theoretically infinite stack page the SmiFunctions.

In addition to my superclass I handle closure activation.

"
Class {
	#name : #SmiRealClosureStackInterpreterCorrection,
	#superclass : #SmiStackInterpreterCorrection,
	#category : #'SmiLang-Correction'
}

{ #category : #private }
SmiRealClosureStackInterpreterCorrection >> activateFunction: func [ 
	^ self activateFunction: func closure: nil
]

{ #category : #private }
SmiRealClosureStackInterpreterCorrection >> activateFunction: func closure: closureOrNil [
	self push: programCounter.
	self push: currentFunction.
	self push: framePointer.
	framePointer := stackPointer.
	
	currentFunction := func.
	programCounter := 0.
	self push: self frameWrapperFlag. "for frameWrapper"
	self push: (closureOrNil ifNil: [ self notClosureFlag ]).
	closureOrNil ifNotNil: [ 
			closureOrNil tempVector ifNotNil: [ :tv | self push: tv ] ].
	currentFunction numTemps timesRepeat: [ self push: 0 ]
]

{ #category : #'frame accessing' }
SmiRealClosureStackInterpreterCorrection >> closureFromFP: fp [
	^ currentStackPage at: fp + 2
]

{ #category : #'frame accessing' }
SmiRealClosureStackInterpreterCorrection >> frameWrapperFlag [
	^ #noFrameWrapper
]

{ #category : #'frame accessing' }
SmiRealClosureStackInterpreterCorrection >> frameWrapperFromFP: fp [
	^ currentStackPage at: fp + 1
]

{ #category : #'frame accessing' }
SmiRealClosureStackInterpreterCorrection >> getActiveFrameWrapper [
	| wrapper |
	^ (wrapper := currentStackPage at: framePointer + 1) == self frameWrapperFlag 
		ifTrue: [ self wrapFrame ]
		ifFalse: [ wrapper ]
]

{ #category : #private }
SmiRealClosureStackInterpreterCorrection >> getTempVect: vectorAccess [
	^ currentStackPage at: framePointer + (self temporaryFrameOffset: vectorAccess tempVectorIndex)
]

{ #category : #private }
SmiRealClosureStackInterpreterCorrection >> isValidFrameWrapper: wrap [
	(self referenceFrame: wrap) ifFalse: [ ^ false ].
	^ (self frameWrapperFromFP: wrap stackFrameIndex) == wrap
]

{ #category : #'frame accessing' }
SmiRealClosureStackInterpreterCorrection >> notClosureFlag [
	^ #notAClosureActivation
]

{ #category : #private }
SmiRealClosureStackInterpreterCorrection >> referenceFrame: wrap [
	"Answers true if the wrapper references a frame pointer"
	| fp toFind |
	fp := framePointer.
	toFind := wrap stackFrameIndex.
	[ toFind > fp ] whileFalse: [ 
		toFind = fp ifTrue: [ ^ true ].
		fp := currentStackPage at: fp ].
	^ false
]

{ #category : #'frame accessing' }
SmiRealClosureStackInterpreterCorrection >> temporaryFrameOffset: index [
	^ (super temporaryFrameOffset: index) + 2
]

{ #category : #visiting }
SmiRealClosureStackInterpreterCorrection >> visitActivateClosure: node [
	"On top of stack is the closure to activate. If it's not a closure raise an exception."
	| closure |
	closure := self pop.
	closure class = SmiVectorClosure ifFalse: [ self error: 'cant activate a Smi' ].
	self activateFunction: closure function closure: closure
]

{ #category : #visiting }
SmiRealClosureStackInterpreterCorrection >> visitCreateTempVector: createTempVect [ 
	self push: (Array new: createTempVect vectorSize withAll: 0)
]

{ #category : #visiting }
SmiRealClosureStackInterpreterCorrection >> visitCreateVectorClosure: createClosure [
	| tempVect closure |
	tempVect := createClosure tempVectorIndex ifNotNil: [ :i | 
			currentStackPage at: framePointer + (self temporaryFrameOffset: i) ].
	closure := SmiVectorClosure new
		function: createClosure function;
		outerFrameWrapper: self getActiveFrameWrapper;
		tempVector: tempVect;
		yourself.
	self push: closure
]

{ #category : #visiting }
SmiRealClosureStackInterpreterCorrection >> visitNonLocalReturnTop: nlr [ 
	| fp wrap retVal |
	fp := framePointer.
	[ (self closureFromFP: fp) == self notClosureFlag ] whileFalse:
		[ wrap := (self closureFromFP: fp) outerFrameWrapper.
		(self isValidFrameWrapper: wrap) ifFalse: [ BlockCannotReturn signal ].
		fp := wrap stackFrameIndex ].
	"fp is live and is the one of the home. nlr can succeed."
	retVal := self top.
	framePointer := fp.
	self return: retVal
]

{ #category : #visiting }
SmiRealClosureStackInterpreterCorrection >> visitPushVectorTemp: vectorPush [
	self push: ((self getTempVect: vectorPush) at: vectorPush tempIndex)
]

{ #category : #visiting }
SmiRealClosureStackInterpreterCorrection >> visitStoreVectorTemp: vectorStore [ 
	(self getTempVect: vectorStore) at: vectorStore tempIndex put: self top
]

{ #category : #'frame accessing' }
SmiRealClosureStackInterpreterCorrection >> wrapFrame [
	^ currentStackPage 
		at: framePointer + 1 
		put: (SmiStackFrameWrapper new
			stackFrameIndex: framePointer;
			yourself)
]
