Class {
	#name : #HOPMostRelevantMethodMapping,
	#superclass : #HOPColorMapping,
	#category : #HopOptimizationVisualizer
}

{ #category : #'as yet unclassified' }
HOPMostRelevantMethodMapping >> computeMappingMetricFor: highlight [
	| allWeights weight |
	self assert: [ highlightCollection notNil ] description: 'Must have a highlight collection'.
	allWeights := {1 . 1 . 10 . 20 . 30 . 100}.
	weight := 0.
	{#imap . #emap . #cmap . #amap . #pmap . #vtable}
		with: allWeights
		do: [ :k :w | 
			| t |
			t := highlightCollection levelOf: (highlight perform: k) for: k.
			weight := weight + (t * w) ].
	^ weight
]
