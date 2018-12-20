Class {
	#name : #HOPVisualizer,
	#superclass : #Object,
	#instVars : [
		'rubricModel'
	],
	#category : #HopOptimizationVisualizer
}

{ #category : #'as yet unclassified' }
HOPVisualizer >> example [
	<script: 'self new example'>
	self 
		openOnJSSource: HOPBasicTest new exampleJS cacheSource: HOPBasicTest new exampleCacheAndLocationJSON
]

{ #category : #'as yet unclassified' }
HOPVisualizer >> exampleRichards [
	<script: 'self new exampleRichards'>
	self 
		openOnJSSource: HOPBasicTest new exampleRichardsJS cacheSource: HOPBasicTest new exampleRichardCacheAndLocationJSON
]

{ #category : #'as yet unclassified' }
HOPVisualizer >> highlightTokenAt: index [
	rubricModel highlightTokenAt: index
]

{ #category : #'as yet unclassified' }
HOPVisualizer >> initialize [
	super initialize.
	rubricModel := HOPRubric new
]

{ #category : #'as yet unclassified' }
HOPVisualizer >> openOnJSFilename: aFilename cacheFilename: cacheFilename [
	"Public method"
	
	"
	self new 
		openOnJSFilename: '/Users/alexandrebergel/Dropbox/GitRepos/HopOptimizationVisualizer/Examples/richards/richards.js' 
		cacheFilename:    '/Users/alexandrebergel/Dropbox/GitRepos/HopOptimizationVisualizer/Examples/richards/traceCache.json' 
	"
	^ self openOnJSSource: aFilename asFileReference contents cacheSource: cacheFilename asFileReference contents
]

{ #category : #'as yet unclassified' }
HOPVisualizer >> openOnJSSource: aJSSource [
	rubricModel openOnSource: aJSSource
]

{ #category : #'as yet unclassified' }
HOPVisualizer >> openOnJSSource: aJSSource cacheSource: cacheSource [
	"Public method"
	self setJSSource: aJSSource cacheSource: cacheSource.
	^ rubricModel open
]

{ #category : #'as yet unclassified' }
HOPVisualizer >> processCacheSource: cacheSource [
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

{ #category : #'as yet unclassified' }
HOPVisualizer >> setJSSource: aJSSource cacheSource: cacheSource [
	"Public method"
	self sourceCode: aJSSource.
	self processCacheSource: cacheSource.

]

{ #category : #'as yet unclassified' }
HOPVisualizer >> sourceCode: aJSSource [
	"Set the source code"
	rubricModel sourceCode: aJSSource
]
