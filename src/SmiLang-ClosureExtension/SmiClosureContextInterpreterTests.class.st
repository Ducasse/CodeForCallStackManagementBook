Class {
	#name : #SmiClosureContextInterpreterTests,
	#superclass : #SmiTests,
	#category : #'SmiLang-ClosureExtension-tests'
}

{ #category : #'as yet unclassified' }
SmiClosureContextInterpreterTests class >> exampleMethods [
	^ super exampleMethods , (SmiAdditionnalExamples methods select: [ :each | each selector beginsWith: #example ])
]

{ #category : #'as yet unclassified' }
SmiClosureContextInterpreterTests class >> expectedResults [
	^ super expectedResults , #(SmiClosure 1 2 1 3 1 24 5 BlockCannotReturn BlockCannotReturn)
]

{ #category : #'as yet unclassified' }
SmiClosureContextInterpreterTests class >> smiCompilerClass [
	^ SmiClosureCompiler 
]

{ #category : #helper }
SmiClosureContextInterpreterTests >> closureClass [
	^ SmiClosure
]

{ #category : #helper }
SmiClosureContextInterpreterTests >> interpreterClass [
	^ SmiClosureContextInterpreter
]

{ #category : #tests }
SmiClosureContextInterpreterTests >> testExample1 [
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
SmiClosureContextInterpreterTests >> testExample10 [
	"This test ensures that the execution of the function example02ClosureActivation is correct.
	-- Source code --
	example02ClosureActivation
	| temp |
	temp := [ 1 ].
	^ temp value
	-- Instructions --
	<1> createClosure
	<2> storeTemp: 1
	<3> pop
	<4> pushTemp: 1
	<5> activateClosure
	<6> returnTop"
	self
		assert: (self runSmiFunction: (self compilePharoMethod: SmiAdditionnalExamples>>#example02ClosureActivation))
		equals: 1
]

{ #category : #tests }
SmiClosureContextInterpreterTests >> testExample11 [
	"This test ensures that the execution of the function example03ClosureTemp is correct.
	-- Source code --
	example03ClosureTemp
	^ [ | temp | temp := 1. temp + 1 ] value
	-- Instructions --
	<1> createClosure
	<2> activateClosure
	<3> returnTop"
	self
		assert: (self runSmiFunction: (self compilePharoMethod: SmiAdditionnalExamples>>#example03ClosureTemp))
		equals: 2
]

{ #category : #tests }
SmiClosureContextInterpreterTests >> testExample12 [
	"This test ensures that the execution of the function example04ClosureRemoteTemp is correct.
	-- Source code --
	example04ClosureRemoteTemp
	| remoteTemp |
	remoteTemp := 1.
	^ [ remoteTemp ] value
	-- Instructions --
	<1> push 1
	<2> storeTemp: 1
	<3> pop
	<4> createClosure
	<5> activateClosure
	<6> returnTop"
	self
		assert: (self runSmiFunction: (self compilePharoMethod: SmiAdditionnalExamples>>#example04ClosureRemoteTemp))
		equals: 1
]

{ #category : #tests }
SmiClosureContextInterpreterTests >> testExample13 [
	"This test ensures that the execution of the function example05ClosureRemoteTemp2 is correct.
	-- Source code --
	example05ClosureRemoteTemp2
	| remoteTemp |
	remoteTemp := 1.
	^ [ remoteTemp := 2. remoteTemp + 1 ] value
	-- Instructions --
	<1> push 1
	<2> storeTemp: 1
	<3> pop
	<4> createClosure
	<5> activateClosure
	<6> returnTop"
	self
		assert: (self runSmiFunction: (self compilePharoMethod: SmiAdditionnalExamples>>#example05ClosureRemoteTemp2))
		equals: 3
]

{ #category : #tests }
SmiClosureContextInterpreterTests >> testExample14 [
	"This test ensures that the execution of the function example06ClosureRemoteTempDeadOuter is correct.
	-- Source code --
	example06ClosureRemoteTempDeadOuter
	^ call closureDeadOuter value
	-- Instructions --
	<1> call closureDeadOuter
	<2> activateClosure
	<3> returnTop"
	self
		assert: (self runSmiFunction: (self compilePharoMethod: SmiAdditionnalExamples>>#example06ClosureRemoteTempDeadOuter))
		equals: 1
]

{ #category : #tests }
SmiClosureContextInterpreterTests >> testExample15 [
	"This test ensures that the execution of the function example07ClosureNestedTemp is correct.
	-- Source code --
	example07ClosureNestedTemp
	| remote11 remote12 |
	remote11 := 11.
	^ [ | remote21 |
		remote12 := [ remote21 := remote11 + 1. remote21 ] value.
		remote21 + remote12 ] value.
	-- Instructions --
	<1> push 11
	<2> storeTemp: 1
	<3> pop
	<4> createClosure
	<5> activateClosure
	<6> returnTop"
	self
		assert: (self runSmiFunction: (self compilePharoMethod: SmiAdditionnalExamples>>#example07ClosureNestedTemp))
		equals: 24
]

{ #category : #tests }
SmiClosureContextInterpreterTests >> testExample16 [
	"This test ensures that the execution of the function example08ClosureNLR is correct.
	-- Source code --
	example08ClosureNLR
	call activateClosure: [ ^ 5 ].
	^ 10
	-- Instructions --
	<1> createClosure
	<2> call activateClosure:
	<3> push 10
	<4> returnTop"
	self
		assert: (self runSmiFunction: (self compilePharoMethod: SmiAdditionnalExamples>>#example08ClosureNLR))
		equals: 5
]

{ #category : #tests }
SmiClosureContextInterpreterTests >> testExample17 [
	"This test ensures that the execution of the function example09CannotReturn is correct.
	-- Source code --
	example09CannotReturn
	^ call closureDeadOuter2 value
	-- Instructions --
	<1> call closureDeadOuter2
	<2> activateClosure
	<3> returnTop"
	self should: [self runSmiFunction: (self compilePharoMethod: SmiAdditionnalExamples>>#example09CannotReturn)] raise: BlockCannotReturn
]

{ #category : #tests }
SmiClosureContextInterpreterTests >> testExample18 [
	"This test ensures that the execution of the function example10CannotReturn2 is correct.
	-- Source code --
	example10CannotReturn2
	^ call closureDeadOuter3 value
	-- Instructions --
	<1> call closureDeadOuter3
	<2> activateClosure
	<3> returnTop"
	self should: [self runSmiFunction: (self compilePharoMethod: SmiAdditionnalExamples>>#example10CannotReturn2)] raise: BlockCannotReturn
]

{ #category : #tests }
SmiClosureContextInterpreterTests >> testExample2 [
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
SmiClosureContextInterpreterTests >> testExample3 [
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
SmiClosureContextInterpreterTests >> testExample4 [
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
SmiClosureContextInterpreterTests >> testExample5 [
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
SmiClosureContextInterpreterTests >> testExample6 [
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
SmiClosureContextInterpreterTests >> testExample7 [
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
SmiClosureContextInterpreterTests >> testExample8 [
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

{ #category : #tests }
SmiClosureContextInterpreterTests >> testExample9 [
	"This test ensures that the execution of the function example01Closure is correct.
	-- Source code --
	example01Closure
	^ [ 1 ]
	-- Instructions --
	<1> createClosure
	<2> returnTop"
	self assert: ((self runSmiFunction: (self compilePharoMethod: SmiAdditionnalExamples>>#example01Closure)) isKindOf: self closureClass)
]
