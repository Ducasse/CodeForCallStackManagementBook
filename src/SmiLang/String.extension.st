Extension { #name : #String }

{ #category : #'*SmiLang' }
String >> asPillarSourceCode [
	<pillarDocumentation> 
	| stream |
	stream := '' writeStream.
	stream 
		<< '[[['
		<< String cr
		<< self
		<< String cr
		<< ']]]'.
	^ stream contents
]
