Class {
	#name : #HOPVisualizer,
	#superclass : #Object,
	#instVars : [
		'rubricModel',
		'colorMapping'
	],
	#category : #HopOptimizationVisualizer
}

{ #category : #accessing }
HOPVisualizer >> colorMapping [
	"Return the color mapping used by the highlights"
	^ colorMapping 
]

{ #category : #accessing }
HOPVisualizer >> colorMapping: aCM [
	"Set the color mapping used by the highlights"
	colorMapping := aCM
]

{ #category : #'public - examples' }
HOPVisualizer >> example [
	<script: 'self new example'>
	^ self 
		openOnJSSource: HOPBasicTest new exampleJS cacheSource: HOPBasicTest new exampleCacheAndLocationJSON
]

{ #category : #'public - examples' }
HOPVisualizer >> exampleRichards [
	<script: 'self new exampleRichards'>
	^ self 
		openOnJSSource: HOPBasicTest new exampleRichardsJS cacheSource: HOPBasicTest new exampleRichardCacheAndLocationJSON
]

{ #category : #initialize }
HOPVisualizer >> initialize [
	super initialize.
	rubricModel := HOPRubric new.
	colorMapping := HOPMostRelevantMethodMapping new.
	"colorMapping := HOPNumberOfExecutionMapping new."
]

{ #category : #'public - opening' }
HOPVisualizer >> openOnJSFilename: aFilename cacheFilename: cacheFilename [
	"Public method"
	
	"
	self new 
		openOnJSFilename: '/Users/alexandrebergel/Dropbox/GitRepos/HopOptimizationVisualizer/Examples/richards/richards.js' 
		cacheFilename:    '/Users/alexandrebergel/Dropbox/GitRepos/HopOptimizationVisualizer/Examples/richards/traceCache.json' 
	"
	^ self openOnJSSource: aFilename asFileReference contents cacheSource: cacheFilename asFileReference contents
]

{ #category : #'public - opening' }
HOPVisualizer >> openOnJSSource: aJSSource [
	rubricModel openOnSource: aJSSource
]

{ #category : #'public - opening' }
HOPVisualizer >> openOnJSSource: aJSSource cacheSource: cacheSource [
	"Public method"
	self setJSSource: aJSSource cacheSource: cacheSource.
	^ rubricModel open
]

{ #category : #private }
HOPVisualizer >> processCacheSource: cacheSource [
	"Populate the rubric model"
	| allCaches h |
	allCaches := ((STONJSON fromString: cacheSource) at: 'sources') first at: 'caches'.
	allCaches do: [ :dic |
		(dic at: 'point') ~= -1 ifTrue: [
			h := HOPCodeHighlight new.
			h usage: (dic at: 'usage').
			h index: (dic at: 'point') + 2.
			h cmap: (dic at: 'cmap' ifAbsent: [ 0 ]).
			h emap: (dic at: 'emap' ifAbsent: [ 0 ]).
			h amap: (dic at: 'amap' ifAbsent: [ 0 ]).
			h pmap: (dic at: 'pmap' ifAbsent: [ 0 ]).
			h imap: (dic at: 'imap' ifAbsent: [ 0 ]).
			h vtable: (dic at: 'vtable' ifAbsent: [ 0 ]).
			rubricModel addHighlight: h
		]
	].

]

{ #category : #accessing }
HOPVisualizer >> rubricModel [
	"Return the Rubric model"
	^ rubricModel 
]

{ #category : #private }
HOPVisualizer >> setJSSource: aJSSource cacheSource: cacheSource [
	"Public method"
	self sourceCode: aJSSource.
	self processCacheSource: cacheSource.
	rubricModel colorMapping: colorMapping.

]

{ #category : #private }
HOPVisualizer >> sourceCode: aJSSource [
	"Set the source code"
	rubricModel sourceCode: aJSSource
]
