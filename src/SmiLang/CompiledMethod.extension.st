Extension { #name : #CompiledMethod }

{ #category : #'*SmiLang' }
CompiledMethod >> pillarPrintOn: stream compiler: compiler closuresAt: closureIndexes [
	<pillarDocumentation> 
	| function |
	function := compiler new compilePharoMethod: self.
	stream << 'Source code:'.
	stream cr.
	stream << self sourceCode asPillarSourceCode.
	stream cr.
	stream << 'Instructions:'.
	stream cr.
	stream << function printString asPillarSourceCode.
	closureIndexes do: [ :index |
		stream cr.
		stream << 'Closure Instructions:'.
		stream cr.
		stream << (function instructionAt: index) function printString asPillarSourceCode ].
]
