Extension { #name : #String }

{ #category : #'*HopOptimizationVisualizer' }
String >> indicesOfTokens: aTokenAsString [

	"
	'

function Cons( a, d ) {
  this.car = a;
  this.cdr = d;
}

function interval( min, max ) {
  if( min > max ) {
     return null;
  } else {
     return new Cons( min, interval( min + 1, max ) );
  }
}' indicesOfTokens: 'function'
	
	"
	| indices run |
	indices := OrderedCollection new.
	run := -1.
	[ run ~= 0 ] whileTrue: [
		run := self indexOfSubCollection: aTokenAsString startingAt: run + 1.
		indices add: run ].
	^ indices allButLast
]
