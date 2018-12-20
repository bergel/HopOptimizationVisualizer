Class {
	#name : #HOPCodeHighlightCollectionTest,
	#superclass : #HOPTest,
	#instVars : [
		'c'
	],
	#category : #HopOptimizationVisualizer
}

{ #category : #running }
HOPCodeHighlightCollectionTest >> setUp [
	c := HOPCodeHighlightCollection new
]

{ #category : #running }
HOPCodeHighlightCollectionTest >> testEmpty [
	self assert: c numberOfHighlights equals: 0
]

{ #category : #running }
HOPCodeHighlightCollectionTest >> testWithOneHighlight [
	c add: HOPCodeHighlight new.
	self assert: c numberOfHighlights equals: 1
]
