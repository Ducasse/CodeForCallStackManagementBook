"
Analyze an AST and figures out which variables are locals  to a scope and which ones are accessed from multiple scopes. I also answer the number of temps accessed from several scopes in the method.

variables <Dictionary <var name -> binding>> list of var names already analayzed and the binding they map to.
scopeStack <Stack of array of var names>  top scope is the list of variables declared in the current scope
remotes <Collection of var names> list of variables that are accessed through several scopes
"
Class {
	#name : #SmiSemanticAnalyzer,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'scopeStack',
		'remotes'
	],
	#category : #'SmiLang-StackClosureExtension-compiler'
}

{ #category : #public }
SmiSemanticAnalyzer >> analyzeAST: ast [
	self pushScope: ast.
	ast acceptVisitor: self.
	^ remotes asSet asOrderedCollection
		remove: #call ifAbsent: nil; "only in Pharo AST"
		yourself
]

{ #category : #scopes }
SmiSemanticAnalyzer >> currentScope [
	^ scopeStack top
]

{ #category : #initialization }
SmiSemanticAnalyzer >> initialize [

	super initialize.

	scopeStack := Stack new.
	remotes := OrderedCollection new.
]

{ #category : #scopes }
SmiSemanticAnalyzer >> popScope [
	scopeStack pop
]

{ #category : #scopes }
SmiSemanticAnalyzer >> pushScope: ast [
	scopeStack push: ast argumentNames, ast temporaryNames
]

{ #category : #visiting }
SmiSemanticAnalyzer >> visitBlockNode: blockNode [
	self pushScope: blockNode.
	super visitBlockNode: blockNode.
	self popScope.
]

{ #category : #visiting }
SmiSemanticAnalyzer >> visitVariableNode: var [ 
	(self currentScope includes: var name) ifFalse: [ 
		remotes add: var name ]
]
