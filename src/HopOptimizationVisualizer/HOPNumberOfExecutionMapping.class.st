Class {
	#name : #HOPNumberOfExecutionMapping,
	#superclass : #HOPColorMapping,
	#category : #HopOptimizationVisualizer
}

{ #category : #'as yet unclassified' }
HOPNumberOfExecutionMapping >> computeMappingMetricFor: highlight [
	^ {#imap . #emap . #cmap . #amap . #pmap . #vtable} inject: 0 into: [ :sum :k |
		sum + (highlight perform: k) ]
]
