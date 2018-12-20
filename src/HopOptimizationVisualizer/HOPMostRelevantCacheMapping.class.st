Class {
	#name : #HOPMostRelevantCacheMapping,
	#superclass : #HOPColorMapping,
	#category : #HopOptimizationVisualizer
}

{ #category : #'as yet unclassified' }
HOPMostRelevantCacheMapping >> computeMappingMetricFor: highlight [
	| t indexOfMax |
	self assert: [ highlightCollection notNil ] description: 'Must have a highlight collection'.

	indexOfMax := 0.
	t := -1.
	{#imap . #emap . #cmap . #amap . #pmap . #vtable}
		doWithIndex: [ :k :index | 
			| tv |
			tv := highlight perform: k.
			tv > t ifTrue: [ indexOfMax := index. t := tv ] ].
	^ indexOfMax
	
]
