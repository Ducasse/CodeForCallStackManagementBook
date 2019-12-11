"
I represent a temporay variable binding. 

remote <Boolean> if true, I am accessed from several scopes, else I am local to a scope
"
Class {
	#name : #SmiBinding,
	#superclass : #SmiCompiler,
	#instVars : [
		'remote'
	],
	#category : #'SmiLang-StackClosureExtension-compiler'
}

{ #category : #initialization }
SmiBinding >> initialize [

	super initialize.

	remote := false.
]

{ #category : #accessing }
SmiBinding >> remote [
	^ remote
]

{ #category : #accessing }
SmiBinding >> remote: anObject [
	remote := anObject
]
