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
		'vtable',
		'token',
		'highlightCollection',
		'weightedSumCache'
	],
	#classVars : [
		'ColorTable'
	],
	#category : #HopOptimizationVisualizer
}

{ #category : #'accessing caches' }
HOPCodeHighlight >> amap [
	^ amap
]

{ #category : #'accessing caches' }
HOPCodeHighlight >> amap: aPositiveInteger [
	amap := aPositiveInteger
]

{ #category : #'accessing caches' }
HOPCodeHighlight >> cmap [
	^ cmap
]

{ #category : #'accessing caches' }
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

	| allWeights weight tt |
	self initializeColorTableIfNecessary.
	"values := { amap . cmap . imap. pmap. emap . vtable }."
	"imap = iclass
	emap is like imap, but only for writting
	amap = we use an accessor (Maybe we should use a different visual cue)
	pmap = the property is found within the prototype chain
	"
"	values := { imap . emap . cmap  . amap . pmap . vtable }.
	values
		with: ColorTable
		do: [ :v :c | 
			v > 0
				ifTrue: [ ^ c alpha: 0.3 ] ]."

	tt := self weightedSum / (highlightCollection highlights collect: #weightedSum) max.

	^ ColorTable at: (ColorTable size - 1 * tt) asInteger + 1
	"^ Color gray alpha: 0.3"
]

{ #category : #initialization }
HOPCodeHighlight >> displayString [
	| w |
	w := WriteStream on: String new.
	w nextPutAll: 'imap = '; nextPutAll: imap asStringWithCommas; cr.
	w nextPutAll: 'cmap = '; nextPutAll: cmap asStringWithCommas; cr.
	w nextPutAll: 'emap = '; nextPutAll: emap asStringWithCommas; cr.
	w nextPutAll: 'amap = '; nextPutAll: amap asStringWithCommas; cr.
	w nextPutAll: 'pmap = '; nextPutAll: pmap asStringWithCommas; cr.
	w nextPutAll: 'vtable = '; nextPutAll: vtable asStringWithCommas; cr.
	w cr.
	w nextPutAll: 'usage = '; nextPutAll: usage.
	^ w contents
]

{ #category : #'public - actions' }
HOPCodeHighlight >> doInspect [
	self inspect
]

{ #category : #'accessing caches' }
HOPCodeHighlight >> emap [
	^ emap
]

{ #category : #'accessing caches' }
HOPCodeHighlight >> emap: aPositiveInteger [
	emap := aPositiveInteger
]

{ #category : #visualization }
HOPCodeHighlight >> gtBoxPlotsIn: composite [
	<gtInspectorPresentationOrder: -20>
	composite roassal2
		title: 'BoxPlot';
		initializeView: [ self visualizeBoxplots ]
]

{ #category : #accessing }
HOPCodeHighlight >> highlightCollection [
	"Collection in which I am contained. Return nil if not yet set"
	^ highlightCollection
]

{ #category : #accessing }
HOPCodeHighlight >> highlightCollection: aCodeHighlightCollection [
	"Set the collection in which I am contained. Return nil if not yet set"
	highlightCollection := aCodeHighlightCollection
]

{ #category : #'accessing caches' }
HOPCodeHighlight >> imap [
	^ imap
]

{ #category : #'accessing caches' }
HOPCodeHighlight >> imap: aPositiveInteger [
	imap := aPositiveInteger
]

{ #category : #'accessing caches' }
HOPCodeHighlight >> index [
	^ index
]

{ #category : #'accessing caches' }
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
	usage := 'NOT SPECIFIED'.
	token := 'NOT SPECIFIED'.
]

{ #category : #initialization }
HOPCodeHighlight >> initializeColorTableIfNecessary [
	ColorTable
		ifNil: [ ColorTable := {(Color h: 120 s: 1 l: 0.5).
			(Color h: 86 s: 1 l: 0.5).
			(Color h: 62 s: 1 l: 0.5).
			(Color h: 48 s: 1 l: 0.5).
			(Color h: 24 s: 1 l: 0.5).
			(Color h: 0 s: 1 l: 0.5)} ]
]

{ #category : #'accessing caches' }
HOPCodeHighlight >> pmap [
	^ pmap
]

{ #category : #'accessing caches' }
HOPCodeHighlight >> pmap: aPositiveInteger [
	pmap := aPositiveInteger
]

{ #category : #accessing }
HOPCodeHighlight >> token [
	"Token related to which the highlight refers to"
	^ token
]

{ #category : #accessing }
HOPCodeHighlight >> token: aTokenAsString [
	"Set the token to which the highlight refers to"
	token := aTokenAsString
]

{ #category : #'accessing caches' }
HOPCodeHighlight >> usage [
	^ usage
]

{ #category : #'accessing caches' }
HOPCodeHighlight >> usage: aPositiveInteger [
	usage := aPositiveInteger
]

{ #category : #visualization }
HOPCodeHighlight >> visualizeBoxplots [

| b d deco |
b := RTGrapher new.

#(#imap #cmap #emap #amap #pmap #vtable) doWithIndex: [ :k :ind | 
	(self perform: k) ~= 0 ifTrue: [
		d := RTBoxPlotDataSet new.
		d outlierShape size: 5.
		d points: (highlightCollection collect: k).
		d y: #yourself.
		d x: ind.
		b add: d.
		
		d := RTData new.
		d dotShape color: Color red.
		d points: (Array with: self).
		d y: k.
		d x: ind.
		b add: d.
		
		deco := RTHorizontalAllValuesDecorator new.
		"deco labelRotation: -45;"
		deco labelConversion: [ :vv | k ].
		b addDecorator: deco.
	]
].

b axisX noTick.
^ b
]

{ #category : #'accessing caches' }
HOPCodeHighlight >> vtable [
	^ vtable
]

{ #category : #'accessing caches' }
HOPCodeHighlight >> vtable: aPositiveInteger [
	vtable := aPositiveInteger
]

{ #category : #accessing }
HOPCodeHighlight >> weightedSum [

	| allWeights weight |
	weightedSumCache ifNotNil: [ ^ weightedSumCache ].
	
	allWeights := { 1 . 1 . 10 . 20 . 30 . 100 }.
	weight := 0.

	{ #imap . #emap . #cmap  . #amap . #pmap . #vtable } 
	with: allWeights
	do: [ :k :w |
		| t |
		t := highlightCollection levelOf: (self perform: k) for: k.
		weight := weight + (t * w)
	].
	^ weightedSumCache := weight asFloat
]
