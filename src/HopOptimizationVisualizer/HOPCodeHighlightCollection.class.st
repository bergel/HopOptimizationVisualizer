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

{ #category : #enumerating }
HOPCodeHighlightCollection >> do: aOneArgBlock [
	"The argument is evaluated for each highlight. The block takes the highlight as argument"
	highlights do: aOneArgBlock
]

{ #category : #initialization }
HOPCodeHighlightCollection >> initialize [
	super initialize.
	highlights := OrderedCollection new.
]

{ #category : #initialization }
HOPCodeHighlightCollection >> numberOfHighlights [
	"Return the number of highlights added to the collection"
	^ highlights size
]
