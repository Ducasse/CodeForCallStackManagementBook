"
I am an extended version of the SmiCompiler which can compile closures.
"
Class {
	#name : #SmiClosureCompiler,
	#superclass : #SmiCompiler,
	#instVars : [
		'outerCompiler'
	],
	#category : #'SmiLang-ClosureExtension-compiler'
}

{ #category : #private }
SmiClosureCompiler >> compileBlock: blockAST [
	func := (self compileFunction: blockAST)
		funcName: #noname;
		yourself.
	func instructions last class = SmiNonLocalReturnTop 
		ifFalse: [ func addInstruction: SmiReturnTop new ].
	^ func
]

{ #category : #private }
SmiClosureCompiler >> createClosure: closureClass ast: block [
	^ closureClass new
		function: (self class new 
			outerCompiler: self;
			compileBlock: block);
		yourself
]

{ #category : #accessing }
SmiClosureCompiler >> outerCompiler [
	^ outerCompiler
]

{ #category : #accessing }
SmiClosureCompiler >> outerCompiler: anObject [
	outerCompiler := anObject
]

{ #category : #private }
SmiClosureCompiler >> pushOperationFor: name [
	| compiler index |
	(self tempIndexFor: name) ifNotNil: [ :tempIndex | ^ super pushOperationFor: name ].
	compiler := self.
	index := 0.
	[ compiler := compiler outerCompiler.
	index := index + 1.
	(compiler tempIndexFor: name) ifNotNil: [ :tempIndex |
		^ SmiPushRemoteTemp new
			contextIndex: index;
			tempIndex: tempIndex;
			yourself ] ] repeat.
]

{ #category : #private }
SmiClosureCompiler >> storeOperationFor: name [
	| compiler index |
	(self tempIndexFor: name) ifNotNil: [ :tempIndex | ^ super storeOperationFor: name ].
	compiler := self.
	index := 0.
	[ compiler := compiler outerCompiler.
	index := index + 1.
	(compiler tempIndexFor: name) ifNotNil: [ :tempIndex |
		^ SmiStoreRemoteTemp new
			contextIndex: index;
			tempIndex: tempIndex;
			yourself ] ] repeat.
]

{ #category : #visiting }
SmiClosureCompiler >> visitBlockNode: block [
	func addInstruction: (self createClosure: SmiCreateClosure ast: block).
	self push.
]

{ #category : #visiting }
SmiClosureCompiler >> visitClosureActivation: msg [
	func addInstruction: SmiActivateClosure new.
	
]

{ #category : #visiting }
SmiClosureCompiler >> visitMessageNode: msg [	
	msg selector = #value ifTrue: [ 
		msg receiver acceptVisitor: self.
		^ self visitClosureActivation: msg ].
	^ super visitMessageNode: msg	
]

{ #category : #visiting }
SmiClosureCompiler >> visitReturnNode: return [	
	outerCompiler ifNil: [ ^ super visitReturnNode: return ].
	return value acceptVisitor: self.
	func addInstruction: SmiNonLocalReturnTop new.
]
