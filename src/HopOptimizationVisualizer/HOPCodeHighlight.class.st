Class {
	#name : #HOPCodeHighlight,
	#superclass : #Object,
	#instVars : [
		'index',
		'usage',
		'imap',
		'emap',
		'cmap',
		'pmap',
		'amap',
		'vtable'
	],
	#category : #HopOptimizationVisualizer
}

{ #category : #accessing }
HOPCodeHighlight >> amap [
	^ amap
]

{ #category : #accessing }
HOPCodeHighlight >> amap: aPositiveInteger [
	amap := aPositiveInteger
]

{ #category : #accessing }
HOPCodeHighlight >> cmap [
	^ cmap
]

{ #category : #accessing }
HOPCodeHighlight >> cmap: aPositiveInteger [
	cmap := aPositiveInteger
]

{ #category : #accessing }
HOPCodeHighlight >> emap [
	^ emap
]

{ #category : #accessing }
HOPCodeHighlight >> emap: aPositiveInteger [
	emap := aPositiveInteger
]

{ #category : #accessing }
HOPCodeHighlight >> imap [
	^ imap
]

{ #category : #accessing }
HOPCodeHighlight >> imap: aPositiveInteger [
	imap := aPositiveInteger
]

{ #category : #accessing }
HOPCodeHighlight >> index [
	^ index
]

{ #category : #accessing }
HOPCodeHighlight >> index: aPositiveInteger [
	index := aPositiveInteger
]

{ #category : #initialization }
HOPCodeHighlight >> initialize [
	super initialize.
	imap := 0.
	emap := 0. 
	cmap := 0.
	pmap := 0.
	amap := 0.
	vtable := 0.
	index := -1.
	usage := 'NOT SPECIFIED'
]

{ #category : #accessing }
HOPCodeHighlight >> pmap [
	^ pmap
]

{ #category : #accessing }
HOPCodeHighlight >> pmap: aPositiveInteger [
	pmap := aPositiveInteger
]

{ #category : #accessing }
HOPCodeHighlight >> usage [
	^ usage
]

{ #category : #accessing }
HOPCodeHighlight >> usage: aPositiveInteger [
	usage := aPositiveInteger
]

{ #category : #accessing }
HOPCodeHighlight >> vtable [
	^ vtable
]

{ #category : #accessing }
HOPCodeHighlight >> vtable: aPositiveInteger [
	vtable := aPositiveInteger
]
