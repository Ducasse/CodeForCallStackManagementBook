Class {
	#name : #SmiTests,
	#superclass : #TestCase,
	#category : #'SmiLang-tests'
}

{ #category : #accessing }
SmiTests class >> exampleMethods [
	^ SmiExamples methods select: [ :each | each selector beginsWith: #example ]
]

{ #category : #accessing }
SmiTests class >> exampleMethodsSorted [
	^ self exampleMethods sort: [ :a :b | a methodClass == b methodClass 
			ifTrue: [ a selector < b selector ]
			ifFalse: [ a methodClass name > b methodClass name ] ]
]

{ #category : #accessing }
SmiTests class >> expectedResults [
	^ #(1 3 -1 6 1 5 3 4)
]

{ #category : #'code generation' }
SmiTests class >> genBlockCannotReturnTest: exampleMethod expectedResult: expectedResult on: s [
	s << 'self should: ['.
	self genCompileAndRun: exampleMethod on: s.
	s <<  '] raise: BlockCannotReturn'
]

{ #category : #'code generation' }
SmiTests class >> genClosureTest: exampleMethod expectedResult: expectedResult on: s [
	s << 'self assert: (('.
	self genCompileAndRun: exampleMethod on: s.
	s <<  ') isKindOf: self closureClass)'
]

{ #category : #'code generation' }
SmiTests class >> genComment: exampleMethod on: stream [
	stream 
		<< '"This test ensures that the execution of the function ' 
		<< exampleMethod selector
		<< ' is correct.'
		<< String cr 
		<< String tab 
		<< '-- Source code --'
		<< String cr 
		<< String tab 
		<< exampleMethod sourceCode
		<< String cr 
		<< String tab 
		<< '-- Instructions --'.
		(self smiCompilerClass new compilePharoMethod: exampleMethod) printInstructions: stream.
	stream
		<< '"'
		<< String cr 
		<< String tab 
]

{ #category : #'code generation' }
SmiTests class >> genCompileAndRun: method on: stream [
	stream
		<< 'self runSmiFunction: (self compilePharoMethod: '
		<< method printString 
		<< ')'
]

{ #category : #'code generation' }
SmiTests class >> genHeaderOn: stream method: exampleMethod numTest: numTest [ 
	stream 
		<< 'testExample' 
		<< numTest printString 
		<< String cr 
		<< String tab
		"<< '<generatedFrom: #genTests>' 
		<< String cr 
		<< String tab".
	self genComment: exampleMethod on: stream.
]

{ #category : #'code generation' }
SmiTests class >> genSmiTest: exampleMethod expectedResult: expectedResult on: s [
	s 
		<< 'self'
		<< String cr 
		<< String tab
		<< String tab
		<< 'assert: ('.
	self genCompileAndRun: exampleMethod on: s. 
	s
		<< ')'
		<< String cr 
		<< String tab
		<< String tab
		<< 'equals: ' 
		<< expectedResult printString.
]

{ #category : #'code generation' }
SmiTests class >> genTest: exampleMethod expectedResult: expectedResult numTest: numTest [
	| s |
	s := '' writeStream.
	self genHeaderOn: s method: exampleMethod numTest: numTest.
	expectedResult class == SmallInteger 	
		ifTrue: [ self genSmiTest: exampleMethod expectedResult: expectedResult on: s ]
		ifFalse: [
			expectedResult == #BlockCannotReturn 	
				ifTrue: [ self genBlockCannotReturnTest: exampleMethod expectedResult: expectedResult on: s ]
				ifFalse: [ self genClosureTest: exampleMethod expectedResult: expectedResult on: s ] ].
	self 
		compile: s contents
	 	classified: #tests
	
]

{ #category : #'code generation' }
SmiTests class >> genTests [
	"
	self allSubclasses do: [ :each | each genTests ]
	"
	self exampleMethodsSorted withIndexDo: [ :method :i |
		self genTest: method expectedResult: (self expectedResults at: i) numTest: i ]
]

{ #category : #accessing }
SmiTests class >> smiCompilerClass [
	^ SmiCompiler
]

{ #category : #helper }
SmiTests >> compilePharoMethod: method [
	^ self compilerClass new compilePharoMethod: method
	
]

{ #category : #helper }
SmiTests >> compilerClass [ 
	^ self class smiCompilerClass
	
]

{ #category : #helper }
SmiTests >> interpreterClass [
	self subclassResponsibility 
	
]

{ #category : #helper }
SmiTests >> runSmiFunction: function [
	^ self interpreterClass new interpret: function
	
]
