"
Executable function of SmiLang
	funcName <String> name of the function
	numArguments <Smi> 
	numTemps <Smi> (does not include arguments)
	stackSize <Smi> maximum size of stack, including temps and args 
	stackOperations <OrderedCollection of StackOperation> instructions to execute the function
	
"
Class {
	#name : #SmiFunction,
	#superclass : #Object,
	#instVars : [
		'funcName',
		'numArguments',
		'numTemps',
		'stackSize',
		'instructions'
	],
	#category : #'SmiLang-compiler'
}

{ #category : #accessing }
SmiFunction >> addInstruction: op [
	instructions add: op
]

{ #category : #accessing }
SmiFunction >> funcName [
	^ funcName
]

{ #category : #accessing }
SmiFunction >> funcName: anObject [
	funcName := anObject
]

{ #category : #initialization }
SmiFunction >> initialize [

	super initialize.

	instructions := OrderedCollection new.
]

{ #category : #accessing }
SmiFunction >> instructionAt: index [
	^ instructions at: index
]

{ #category : #accessing }
SmiFunction >> instructions [
	^ instructions
]

{ #category : #accessing }
SmiFunction >> numArgs [
	^ numArguments
]

{ #category : #accessing }
SmiFunction >> numArguments [
	^ numArguments
]

{ #category : #accessing }
SmiFunction >> numArguments: anObject [
	numArguments := anObject
]

{ #category : #accessing }
SmiFunction >> numTemporaries [
	^ numTemps
]

{ #category : #accessing }
SmiFunction >> numTemps [
	^ numTemps
]

{ #category : #accessing }
SmiFunction >> numTemps: anObject [
	numTemps := anObject
]

{ #category : #printing }
SmiFunction >> printInstructions: s [
	instructions withIndexDo: [ :op :index |
		s cr. 
		s tab.
		s nextPut: $<.
		s << index printString.
		s nextPut: $>.
		s space.
		op printOn: s ].
]

{ #category : #printing }
SmiFunction >> printOn: s [
	s << funcName.
	self printInstructions: s
]

{ #category : #accessing }
SmiFunction >> stackSize [
	^ stackSize
]

{ #category : #accessing }
SmiFunction >> stackSize: anObject [
	stackSize := anObject
]
