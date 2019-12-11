"
Specific compiler to compiler closures suitable for the stack interpreter.

remotes <Array of names> temps accessed through several scopes
"
Class {
	#name : #SmiStackClosureCompiler,
	#superclass : #SmiClosureCompiler,
	#instVars : [
		'remotes'
	],
	#category : #'SmiLang-StackClosureExtension-compiler'
}

{ #category : #private }
SmiStackClosureCompiler >> astFor: method [
	| ast |
	ast := super astFor: method.
	remotes := SmiSemanticAnalyzer new analyzeAST: ast.
	^ ast
]

{ #category : #private }
SmiStackClosureCompiler >> copyRequiredArgumentsToTempVector: ast [
	"we move the arguments value to the temp vector if it is supposed to hold them"
	ast argumentNames do: [ :name |
		(remotes includes: name) ifTrue: [ 
			func addInstruction: (SmiPushTemp new tempIndex: (self tempIndex: name)).
			func addInstruction: (SmiStoreVectorTemp new tempIndex: (remotes indexOf: name); tempVectorIndex: self tempVectorIndex ).
			func addInstruction: SmiPop new ] ]
]

{ #category : #private }
SmiStackClosureCompiler >> createClosure: closureClass ast: block [
	| closure |
	closure := super createClosure: SmiCreateVectorClosure ast: block.
	remotes ifNotEmpty: [ closure tempVectorIndex: self tempVectorIndex ].
	^ closure
]

{ #category : #private }
SmiStackClosureCompiler >> createNewFunction: ast [
	super createNewFunction: ast.
	self generateAndSetTempVector: ast.
]

{ #category : #private }
SmiStackClosureCompiler >> createTempVector: ast [
	func addInstruction: (SmiCreateTempVector new vectorSize: remotes size).
	func addInstruction: (SmiStoreTemp new tempIndex: self tempVectorIndex).
	func addInstruction: SmiPop new.
]

{ #category : #private }
SmiStackClosureCompiler >> generateAndSetTempVector: ast [
	remotes ifEmpty: [ ^ self ].
	outerCompiler ifNil: [ self createTempVector: ast ].
	self copyRequiredArgumentsToTempVector: ast
]

{ #category : #private }
SmiStackClosureCompiler >> outerCompiler: anObject [
	super outerCompiler: anObject.
	remotes := anObject remotes
]

{ #category : #private }
SmiStackClosureCompiler >> pushOperationFor: name [	
	(self tempIndexFor: name) ifNotNil: [ :tempIndex | ^ SmiPushTemp new tempIndex: tempIndex ].
	^ SmiPushVectorTemp new 
		tempIndex: (remotes indexOf: name); 
		tempVectorIndex: self tempVectorIndex 
]

{ #category : #private }
SmiStackClosureCompiler >> remotes [
	^ remotes
]

{ #category : #private }
SmiStackClosureCompiler >> storeOperationFor: name [	
	(self tempIndexFor: name) ifNotNil: [ :tempIndex | ^ SmiStoreTemp new tempIndex: tempIndex ].
	^ SmiStoreVectorTemp new 
		tempIndex: (remotes indexOf: name); 
		tempVectorIndex: self tempVectorIndex 
]

{ #category : #private }
SmiStackClosureCompiler >> tempVectorIndex [
	^ tempNames indexOf: #tempVector
	
]

{ #category : #private }
SmiStackClosureCompiler >> tempsFor: ast [
	^ (self withoutRemotes: ast arguments) ,
	(remotes ifEmpty: [ #() ] ifNotEmpty: [ #(tempVector) ]),
	(self withoutRemotes: ast temporaries)
	
]

{ #category : #private }
SmiStackClosureCompiler >> withoutRemotes: collection [
	^ (collection reject: [ :each | remotes includes: each name ])
		collect: [ :each | each name ]
]
