Class {
	#name : #HOPColorMapping,
	#superclass : #Object,
	#instVars : [
		'highlightCollection'
	],
	#category : #HopOptimizationVisualizer
}

{ #category : #'as yet unclassified' }
HOPColorMapping >> computeMappingMetricFor: highlight [
	self subclassResponsibility 
]

{ #category : #accessing }
HOPColorMapping >> highlightCollection [
	^ highlightCollection
]

{ #category : #accessing }
HOPColorMapping >> highlightCollection: aHighlightCollection [
	highlightCollection := aHighlightCollection
]
