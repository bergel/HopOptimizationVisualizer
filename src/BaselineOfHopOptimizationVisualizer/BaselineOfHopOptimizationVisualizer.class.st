Class {
	#name : #BaselineOfHopOptimizationVisualizer,
	#superclass : #BaselineOf,
	#category : #BaselineOfHopOptimizationVisualizer
}

{ #category : #baselines }
BaselineOfHopOptimizationVisualizer >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ "			spec baseline: 'GToolkitExamples' with: [ 
				spec repository: 'github://feenkcom/gtoolkit-examples/src' ]."
			spec package: 'HopOptimizationVisualizer'.
			spec group: 'default' with: #('HopOptimizationVisualizer') ]
]
