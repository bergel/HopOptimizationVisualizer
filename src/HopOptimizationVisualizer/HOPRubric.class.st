Class {
	#name : #HOPRubric,
	#superclass : #Model,
	#instVars : [
		'sourceCode',
		'segments',
		'highlightCollection',
		'colorMapping'
	],
	#category : #HopOptimizationVisualizer
}

{ #category : #accessing }
HOPRubric >> addHighlight: anHighlight [
	anHighlight index = -1 ifTrue: [ ^ self ].
	anHighlight index > self sourceCode size ifTrue: [ ^ self ].
	
	anHighlight token: (self tokenAtIndex: anHighlight index).
	highlightCollection add: anHighlight.
	
"	seg := RubPlainSegmentMorph from: index to: index + token size.
	seg setBalloonText: 'hello'.
	seg color: (Color green alpha: 0.3).
	seg icon: (self iconNamed: #smallErrorIcon).
	seg label: 'Please review'."
]

{ #category : #public }
HOPRubric >> addSegment: aSegment [
	segments add: aSegment
]

{ #category : #accessing }
HOPRubric >> bindHighlightsAndColorMapping [
	"Make the highligts use the color mapping"
	colorMapping highlightCollection: highlightCollection.
	highlightCollection do: [ :h | h colorMapping: colorMapping ]
]

{ #category : #accessing }
HOPRubric >> colorMapping [
	^ colorMapping
]

{ #category : #accessing }
HOPRubric >> colorMapping: aColorMapping [
	colorMapping := aColorMapping.
	self bindHighlightsAndColorMapping
]

{ #category : #accessing }
HOPRubric >> highlightFunctionDeclarations [

	| indices |
	indices := self sourceCode asString indicesOfTokens: 'function'.	
	indices do: [ :i |
		"self sourceCode addAttribute: TextColor blue from: i to: (i + 'function' size)"
		self underlineTokenAt: i.
	]

]

{ #category : #public }
HOPRubric >> highlightTokenAt: index [
	| seg token |
	"Not much to do in that case"
	index = -1 ifTrue: [ ^ self ].
	
	token := self tokenAtIndex: index.	
	seg := RubPlainSegmentMorph from: index to: index + token size.	
	seg color: (Color green alpha: 0.3).
	segments add: seg
]

{ #category : #accessing }
HOPRubric >> highlights [
	"Return the highlights"
	^ highlightCollection 
]

{ #category : #initialization }
HOPRubric >> initialize [
	super initialize.
	self setDefaultSourceCode.
	segments := OrderedCollection new.
	highlightCollection := HOPCodeHighlightCollection new
]

{ #category : #public }
HOPRubric >> numberOfHighlights [
	"Return the number of highlights in the rubric model"
	^ highlightCollection numberOfHighlights
]

{ #category : #public }
HOPRubric >> numberOfSegments [
	"Return the number of segments contained in the rubric model"
	^ segments size
]

{ #category : #public }
HOPRubric >> open [
	<script: 'self new open'>
	
	^ self presentation openOn: self sourceCode
]

{ #category : #public }
HOPRubric >> openOnSource: aSourceAsString [

	self presentation openOn: aSourceAsString
]

{ #category : #'instance creation' }
HOPRubric >> presentation [
	"This code is called only when the I am properly initialized"
	"textFont: StandardFonts codeFont;"
	^ GLMCompositePresentation new
		with: [ :a | 
			| t |
			t := a text.
			t wrapped: true.
			t withLineNumbers: true.
			self processHighlights.
			self bindHighlightsAndColorMapping. 
			segments do: [ :s | t addTextSegment: s ].		

			]
]

{ #category : #accessing }
HOPRubric >> processHighlights [
	"Process the highlights"
	| token index segment |
	self bindHighlightsAndColorMapping.
	highlightCollection
		do: [ :anHighlight | 
			token := self tokenAtIndex: anHighlight index.
			index := anHighlight index.
			segment := RubPlainSegmentMorph from: index to: index + token size.
			segment setBalloonText: anHighlight displayString.
			segment color: anHighlight color.
			segment label: 'Inspect'.
			
			"Inspect ThemeIcons for more icons"
			segment icon: (self iconNamed: #smallInspectIt).
			
			segment
				iconBlock: [ :s  | 
					anHighlight doInspect ].
				
			self addSegment: segment ]
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
	"Set the source code in the rubric model"
	
	"Converting the source as Text does not seem to have much impact"
	sourceCode := sourceCodeAsString "asText".
	self highlightFunctionDeclarations.
]

{ #category : #accessing }
HOPRubric >> tokenAtIndex: index [
	| running tokenLetter |
	running := index.
	tokenLetter := OrderedCollection new.
	[ (self sourceCode at: running) isAlphaNumeric ] whileTrue: 
		[ tokenLetter add: (self sourceCode at: running). running := running + 1 ].
	^ tokenLetter collect: #yourself as: String
]

{ #category : #public }
HOPRubric >> underlineTokenAt: index [
	self addSegment: (RubUnderlinedSegmentMorph from: index to: index + (self tokenAtIndex: index) size)
]
