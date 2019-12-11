"
I represent a closure in this extension of SmiLang. A closure is both a function and an enclosing environment, here represented as the outerContext.
"
Class {
	#name : #SmiClosure,
	#superclass : #Object,
	#instVars : [
		'function',
		'outerContext'
	],
	#category : #'SmiLang-ClosureExtension-context interpreter'
}

{ #category : #accessing }
SmiClosure >> function [
	^ function
]

{ #category : #accessing }
SmiClosure >> function: anObject [
	function := anObject
]

{ #category : #accessing }
SmiClosure >> outerContext [
	^ outerContext
]

{ #category : #accessing }
SmiClosure >> outerContext: anObject [
	outerContext := anObject
]
