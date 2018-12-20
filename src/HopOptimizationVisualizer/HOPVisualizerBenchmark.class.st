"
Contains some benchmarks about the source code rendering
"
Class {
	#name : #HOPVisualizerBenchmark,
	#superclass : #Object,
	#category : #HopOptimizationVisualizer
}

{ #category : #benchmarking }
HOPVisualizerBenchmark >> bench01 [

	| h |
	[h := HOPVisualizer new.
	h setJSSource: HOPBasicTest new exampleJS cacheSource: HOPBasicTest new exampleCacheAndLocationJSON] bench.

	'2829.268 per second'
]

{ #category : #benchmarking }
HOPVisualizerBenchmark >> bench02 [

	| window |
	[ [ window := HOPVisualizer new
		openOnJSSource: HOPBasicTest new exampleJS
		cacheSource: HOPBasicTest new exampleCacheAndLocationJSON. ]
		ensure: [ window ifNotNil: [ window delete ] ] ] bench. 
	
	'22.360 per second'

]
