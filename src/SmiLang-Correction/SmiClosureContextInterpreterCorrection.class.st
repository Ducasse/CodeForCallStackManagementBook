"
I am an extension of the SmiContextInterpreter that can interpret closures in addition to the superclass behavior.
"
Class {
	#name : #SmiClosureContextInterpreterCorrection,
	#superclass : #SmiContextInterpreterCorrection,
	#category : #'SmiLang-Correction'
}

{ #category : #private }
SmiClosureContextInterpreterCorrection >> isContextTerminated: context [
	^ context programCounter isNil
]

{ #category : #private }
SmiClosureContextInterpreterCorrection >> terminateTo: context [
	| ctxt |
	ctxt := currentContext.
	[ ctxt = context ] whileFalse: [
		ctxt programCounter: nil.
		ctxt := ctxt sender ]
]

{ #category : #visiting }
SmiClosureContextInterpreterCorrection >> visitActivateClosure: node [
	| closure |
	closure := currentContext pop.
	self newContextFor: closure function contextClass: SmiClosureContext.
	currentContext closure: closure
]

{ #category : #visiting }
SmiClosureContextInterpreterCorrection >> visitCreateClosure: createClosure [
	currentContext push: (SmiClosure new
		function: createClosure function;
		outerContext: currentContext;
		yourself)
]

{ #category : #visiting }
SmiClosureContextInterpreterCorrection >> visitNonLocalReturnTop: nlr [
	| home retValue |
	home := currentContext home.
	(self isContextTerminated: home)
		ifTrue: [ BlockCannotReturn signal ].
	self terminateTo: home sender.
	retValue := currentContext top.
	currentContext := home sender.
	currentContext push: retValue
]

{ #category : #visiting }
SmiClosureContextInterpreterCorrection >> visitPushRemoteTemp: remoteTempAccess [
	| ctxt |
	ctxt := currentContext.
	remoteTempAccess contextIndex timesRepeat: [ ctxt := ctxt closure outerContext ].
	currentContext push: (ctxt stackAt: remoteTempAccess tempIndex)
]

{ #category : #visiting }
SmiClosureContextInterpreterCorrection >> visitReturnTop: node [
	currentContext programCounter: nil.
	super visitReturnTop: node
]

{ #category : #visiting }
SmiClosureContextInterpreterCorrection >> visitStoreRemoteTemp: remoteTempAccess [
	| ctxt |
	ctxt := currentContext.
	remoteTempAccess contextIndex timesRepeat: [ ctxt := ctxt closure outerContext ].
	ctxt stackAt: remoteTempAccess tempIndex put: currentContext top
]
