"
Common abstract superclass of all the operations that can exist in SmiFunctions.
"
Class {
	#name : #SmiInstruction,
	#superclass : #Object,
	#category : #'SmiLang-compiler'
}

{ #category : #'code generation' }
SmiInstruction class >> visitorGeneration [
	SmiInstruction allSubclassesDo: [ :sub |
		sub compile: 'accept: visitor' , String cr , String tab , '^ visitor visit' , (sub name allButFirst: 3) , ': self'.
		SmiContextInterpreter compile: 'visit' , (sub name allButFirst: 3) , ': node' ]
]
