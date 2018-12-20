Class {
	#name : #HOPCodeHighlightCollection,
	#superclass : #Object,
	#instVars : [
		'highlights'
	],
	#category : #HopOptimizationVisualizer
}

{ #category : #adding }
HOPCodeHighlightCollection >> add: anHighlight [
	highlights add: anHighlight.
	anHighlight highlightCollection: self
]

{ #category : #enumerating }
HOPCodeHighlightCollection >> collect: aOneArgBlock [
	"The argument is evaluated for each highlight. The block takes the highlight as argument"
	^ highlights collect: aOneArgBlock
]

{ #category : #accessing }
HOPCodeHighlightCollection >> diff: aSelector [
	"Return the minimum for a given selector"
	^ (highlights max: aSelector) - (highlights collect: aSelector) min
]

{ #category : #enumerating }
HOPCodeHighlightCollection >> do: aOneArgBlock [
	"The argument is evaluated for each highlight. The block takes the highlight as argument"
	highlights do: aOneArgBlock
]

{ #category : #accessing }
HOPCodeHighlightCollection >> highlights [
	^ highlights
]

{ #category : #initialization }
HOPCodeHighlightCollection >> initialize [
	super initialize.
	highlights := OrderedCollection new.
]

{ #category : #accessing }
HOPCodeHighlightCollection >> levelOf: aValue for: aSelector [
	"Return a value between 0.0 and 1.0 for a provided aValue for the cache aSelector"
	^ (aValue - (highlights collect: aSelector) min) / ((self diff: aSelector) + 1)
]

{ #category : #accessing }
HOPCodeHighlightCollection >> max: aSelector [
	"Return the maximum for a given selector"
	^ highlights max: aSelector
]

{ #category : #accessing }
HOPCodeHighlightCollection >> min: aSelector [
	"Return the minimum for a given selector"
	^ highlights min: aSelector
]

{ #category : #initialization }
HOPCodeHighlightCollection >> numberOfHighlights [
	"Return the number of highlights added to the collection"
	^ highlights size
]
