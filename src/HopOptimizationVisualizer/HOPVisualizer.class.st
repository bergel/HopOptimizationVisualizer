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
]

{ #category : #'as yet unclassified' }
HOPVisualizer >> openOnJSSource: aJSSource [
	rubricModel openOnSource: aJSSource
]

{ #category : #'as yet unclassified' }
HOPVisualizer >> openOnJSSource: aJSSource cacheSource: cacheSource [

	rubricModel sourceCode: aJSSource.
	self processCacheSource: cacheSource.
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
