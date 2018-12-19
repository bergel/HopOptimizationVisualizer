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
	#classVars : [
		'ColorTable'
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
HOPCodeHighlight >> color [
	"Color used to presented to Rubric"

	"Inspired from https://coderwall.com/p/dvsxwg/smoothly-transition-from-green-to-red
(1 - 0.00) * 120 = 120 ( green )
(1 - 0.25) * 120 = 90 ( light green )
(1 - 0.50) * 120 = 60 ( yellow )
(1 - 0.75) * 120 = 30 ( orange )
(1 - 1.00) * 120 = 0 ( red )	
	
	"

	| values |
	self initializeColorTableIfNecessary.
	values := { amap . cmap . imap. pmap. emap . vtable }.
	values
		with: ColorTable
		do: [ :v :c | 
			v > 0
				ifTrue: [ ^ c alpha: 0.3 ] ].
	^ Color gray alpha: 0.3
]

{ #category : #initialization }
HOPCodeHighlight >> displayString [
	| w |
	w := WriteStream on: String new.
	w nextPutAll: 'imap = ', imap asString.
	w cr.
	w nextPutAll: 'pmap = ', pmap asString.
	w cr.
	w nextPutAll: 'vtable = ', vtable asString.
	w cr.
	w nextPutAll: 'amap = ', amap asString.
	w cr.
	w nextPutAll: 'cmap = ', cmap asString.
	w cr.
	w nextPutAll: 'emap = ', emap asString.
	w cr.
	^ w contents
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
HOPCodeHighlight >> initializeColorTableIfNecessary [
	ColorTable
		ifNil: [ ColorTable := {(Color h: 120 s: 1 l: 0.5).
			(Color h: 86 s: 1 l: 0.5).
			(Color h: 62 s: 1 l: 0.5).
			(Color h: 48 s: 1 l: 0.5).
			(Color h: 24 s: 1 l: 0.5).
			(Color h: 0 s: 1 l: 0.5)} ]
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
