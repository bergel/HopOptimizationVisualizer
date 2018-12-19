Class {
	#name : #HOPRubric,
	#superclass : #Model,
	#instVars : [
		'sourceCode',
		'segments'
	],
	#category : #HopOptimizationVisualizer
}

{ #category : #public }
HOPRubric >> highlightTokenAt: index [
	| seg |
	seg := RubUnderlinedSegmentMorph from: index to: index + 5.
	seg icon: (self iconNamed: #smallErrorIcon).
	seg label: 'Please review'.
	segments add: seg
]

{ #category : #initialization }
HOPRubric >> initialize [
	super initialize.
	self setDefaultSourceCode.
	segments := OrderedCollection new.
]

{ #category : #public }
HOPRubric >> open [
	<script: 'self new open'>
	self presentation openOn: self sourceCode
]

{ #category : #public }
HOPRubric >> openOnSource: aSourceAsString [

	self presentation openOn: aSourceAsString
]

{ #category : #'instance creation' }
HOPRubric >> presentation [
	"textFont: StandardFonts codeFont;"
	^ GLMCompositePresentation new
		with: [ :a | 
			| t |
			t := a text.
			t wrapped: true.
			t withLineNumbers: true.
			"t font: StandardFonts codeFont."
"			a inspect."
			
"			t withAnnotation: true.
			t wrapped: true.
			t tabWidth: 40.
			t withColumns: true.
"	
			segments do: [ :s | t addTextSegment: s ].		
"			seg := RubUnderlinedSegmentMorph from: 1 to: 29.
			seg icon: (self iconNamed: #smallErrorIcon).
			seg label: 'Please review'.
			seg iconBlock: [ :segment :event | segment delete ].
			t addTextSegment: seg.
			
			seg := RubPlainSegmentMorph from: 535 to: 659.
			seg color: (Color green alpha: 0.3).
			seg icon: (self iconNamed: #smallErrorIcon).
			seg label: 'Remove'.
			seg
				iconBlock: [ :segment :event | 
					segment textArea selectFrom: segment firstIndex to: segment lastIndex.
					segment textArea replaceSelectionWith: ''.
					segment delete ].
			t addTextSegment: seg.
			seg := RubUnderlinedSegmentMorph from: 1000 to: 1030.
			seg icon: (self iconNamed: #smallHelpIcon).
			seg label: 'Print it'.
			seg iconBlock: [ :segment :event | Transcript show: segment getText ].
			t addTextSegment: seg"
			]
]

{ #category : #initialization }
HOPRubric >> setDefaultSourceCode [
	self
		sourceCode:
			'#include <stdio.h>' , String cr
				, 'void main() { printf("HelloWorld"); }'
]

{ #category : #accessing }
HOPRubric >> sourceCode [
	^ sourceCode
]

{ #category : #accessing }
HOPRubric >> sourceCode: sourceCodeAsString [
	sourceCode := sourceCodeAsString
]

{ #category : #public }
HOPRubric >> underlineTokenAt: index [
	| seg |
	seg := RubUnderlinedSegmentMorph from: index to: index + 5.
	seg icon: (self iconNamed: #smallErrorIcon).
	seg label: 'Please review'.
	segments add: seg
]
