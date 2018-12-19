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

	self processCacheSource: cacheSource.
	self openOnJSSource: aJSSource
]

{ #category : #'as yet unclassified' }
HOPVisualizer >> processCacheSource: cacheSource [
	| allCaches |
	allCaches := ((STONJSON fromString: cacheSource) at: 'sources') first at: 'caches'.
	allCaches do: [ :dic |
		self highlightTokenAt: (dic at: 'point') 
	].

]
