Class {
	#name : #SmiContextInterpreterTests,
	#superclass : #SmiTests,
	#category : #'SmiLang-tests'
}

{ #category : #helper }
SmiContextInterpreterTests >> interpreterClass [
	^ SmiContextInterpreter
	
	
]

{ #category : #tests }
SmiContextInterpreterTests >> testExample1 [
	"This test ensures that the execution of the function example01Return is correct.
	-- Source code --
	example01Return
	^ 1
	-- Instructions --
	<1> push 1
	<2> returnTop"
	self
		assert: (self runSmiFunction: (self compilePharoMethod: SmiExamples>>#example01Return))
		equals: 1
]

{ #category : #tests }
SmiContextInterpreterTests >> testExample2 [
	"This test ensures that the execution of the function example02Add is correct.
	-- Source code --
	example02Add
	^ 1 + 2
	-- Instructions --
	<1> push 1
	<2> push 2
	<3> primitive: +
	<4> returnTop"
	self
		assert: (self runSmiFunction: (self compilePharoMethod: SmiExamples>>#example02Add))
		equals: 3
]

{ #category : #tests }
SmiContextInterpreterTests >> testExample3 [
	"This test ensures that the execution of the function example03Minus is correct.
	-- Source code --
	example03Minus
	^ 1 - 2
	-- Instructions --
	<1> push 1
	<2> push 2
	<3> primitive: -
	<4> returnTop"
	self
		assert: (self runSmiFunction: (self compilePharoMethod: SmiExamples>>#example03Minus))
		equals: -1
]

{ #category : #tests }
SmiContextInterpreterTests >> testExample4 [
	"This test ensures that the execution of the function example04Temp is correct.
	-- Source code --
	example04Temp 
	| t |
	t := 1 + 2.
	^ t + 3
	-- Instructions --
	<1> push 1
	<2> push 2
	<3> primitive: +
	<4> storeTemp: 1
	<5> pop
	<6> pushTemp: 1
	<7> push 3
	<8> primitive: +
	<9> returnTop"
	self
		assert: (self runSmiFunction: (self compilePharoMethod: SmiExamples>>#example04Temp))
		equals: 6
]

{ #category : #tests }
SmiContextInterpreterTests >> testExample5 [
	"This test ensures that the execution of the function example05Call is correct.
	-- Source code --
	example05Call
	^ call one
	-- Instructions --
	<1> call one
	<2> returnTop"
	self
		assert: (self runSmiFunction: (self compilePharoMethod: SmiExamples>>#example05Call))
		equals: 1
]

{ #category : #tests }
SmiContextInterpreterTests >> testExample6 [
	"This test ensures that the execution of the function example06CallArgs is correct.
	-- Source code --
	example06CallArgs
	^ call add: 3 to: 2
	-- Instructions --
	<1> push 3
	<2> push 2
	<3> call add:to:
	<4> returnTop"
	self
		assert: (self runSmiFunction: (self compilePharoMethod: SmiExamples>>#example06CallArgs))
		equals: 5
]

{ #category : #tests }
SmiContextInterpreterTests >> testExample7 [
	"This test ensures that the execution of the function example07TempAndCallAndCallArgs is correct.
	-- Source code --
	example07TempAndCallAndCallArgs
	| t |
	t := call one.
	^ call add: t to: 2
	-- Instructions --
	<1> call one
	<2> storeTemp: 1
	<3> pop
	<4> pushTemp: 1
	<5> push 2
	<6> call add:to:
	<7> returnTop"
	self
		assert: (self runSmiFunction: (self compilePharoMethod: SmiExamples>>#example07TempAndCallAndCallArgs))
		equals: 3
]

{ #category : #tests }
SmiContextInterpreterTests >> testExample8 [
	"This test ensures that the execution of the function example08NestedCall is correct.
	-- Source code --
	example08NestedCall
	^ call nestedCall
	-- Instructions --
	<1> call nestedCall
	<2> returnTop"
	self
		assert: (self runSmiFunction: (self compilePharoMethod: SmiExamples>>#example08NestedCall))
		equals: 4
]
