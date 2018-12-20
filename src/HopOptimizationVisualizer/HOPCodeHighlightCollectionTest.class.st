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
	| h |
	h := HOPCodeHighlight new.
	self assert: h highlightCollection isNil.
	c add: h.
	self assert: c numberOfHighlights equals: 1.
	self assert: h highlightCollection equals: c
]
