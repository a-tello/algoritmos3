!classDefinition: #MarsRoverTests category: 'MarsRover-Exercise'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: 'marsRover errorMessage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverTests methodsFor: 'setUp' stamp: 'AT 11/18/2021 16:59:31'!
setUp

	marsRover := MarsRover new.
	errorMessage  := MarsRover invalidCommandErrorDescription .! !


!MarsRoverTests methodsFor: 'mars rover tests' stamp: 'fv 11/18/2021 15:54:28'!
test01RemainOnInitialPositionAfterReceivingEmptyPath

	self assertThat: marsRover movesTo: (0 @ 0) afterReceiving: ''! !

!MarsRoverTests methodsFor: 'mars rover tests' stamp: 'AT 11/18/2021 17:39:05'!
test02RemainOnInitialDirectionAfterReceivingEmptyPath

	self assertThat: marsRover rotatesTo:  North afterReceiving: ''. ! !

!MarsRoverTests methodsFor: 'mars rover tests' stamp: 'AT 11/18/2021 17:39:10'!
test03MovingForwardFromDirectionNorthIncreasesPositionY

	self assertThat: marsRover movesTo: (0 @ 1) afterReceiving: 'f'! !

!MarsRoverTests methodsFor: 'mars rover tests' stamp: 'AT 11/18/2021 17:38:50'!
test04MovingBackwardsFromDirectionNorthDecresesPositionY

	self assertThat: marsRover movesTo: (0 @ -1) afterReceiving: 'b'! !

!MarsRoverTests methodsFor: 'mars rover tests' stamp: 'AT 11/18/2021 17:38:47'!
test05RotateLeftFromDirectionNorthChangesDirectionToWest
	
	self assertThat: marsRover rotatesTo: West afterReceiving: 'l'.! !

!MarsRoverTests methodsFor: 'mars rover tests' stamp: 'AT 11/18/2021 17:38:43'!
test06RotateRightFromDirectionNorthChangesDirectionToEast

	self assertThat: marsRover rotatesTo: East afterReceiving: 'r'.! !

!MarsRoverTests methodsFor: 'mars rover tests' stamp: 'AT 11/18/2021 17:38:40'!
test07MovingForwardFromDirectionEastIncresesPositionX

	self assertThat: marsRover movesTo: (1 @ 0) afterReceiving: 'rf'! !

!MarsRoverTests methodsFor: 'mars rover tests' stamp: 'AT 11/18/2021 17:38:36'!
test08MovingForwardFromDirectionWestDecresesPositionX

	self assertThat: marsRover movesTo: (-1 @ 0) afterReceiving: 'lf'! !

!MarsRoverTests methodsFor: 'mars rover tests' stamp: 'AT 11/18/2021 17:38:33'!
test09RotateLeftFromDirectionWestChangesDirecionToSouth

	self assertThat: marsRover rotatesTo: South afterReceiving: 'll'.! !

!MarsRoverTests methodsFor: 'mars rover tests' stamp: 'AT 11/18/2021 17:38:28'!
test10RotateRightFromDirectionWestChangesDirecionToNorth

	self assertThat: marsRover rotatesTo: North afterReceiving: 'lr'.! !

!MarsRoverTests methodsFor: 'mars rover tests' stamp: 'AT 11/18/2021 17:38:24'!
test11MovingBackwardsFromDirectionEastDecresesPositionX

	self assertThat: marsRover movesTo: (-1 @ 0) afterReceiving: 'rb'! !

!MarsRoverTests methodsFor: 'mars rover tests' stamp: 'AT 11/18/2021 17:38:21'!
test12MovingBackwardsFromDirectionWestIncresesPositionX

	self assertThat: marsRover movesTo: (1 @ 0) afterReceiving: 'lb'! !

!MarsRoverTests methodsFor: 'mars rover tests' stamp: 'AT 11/18/2021 17:38:18'!
test13MovingForwardFromDirectionSouthDecreasesPositionY

	self assertThat: marsRover movesTo: (0 @ -1) afterReceiving: 'llf'! !

!MarsRoverTests methodsFor: 'mars rover tests' stamp: 'AT 11/18/2021 17:38:14'!
test14MovingBackwardsFromDirectionSouthIncresesPositionY

	self assertThat: marsRover movesTo: (0 @ 1) afterReceiving: 'llb'! !

!MarsRoverTests methodsFor: 'mars rover tests' stamp: 'AT 11/18/2021 17:38:02'!
test15RotateLeftFromDirectionEastChangesDirecionToNorth

	self assertThat: marsRover rotatesTo: North afterReceiving: 'rl'.! !

!MarsRoverTests methodsFor: 'mars rover tests' stamp: 'AT 11/18/2021 17:37:03'!
test16RotateRightFromDirectionEastChangesDirecionToSouth

	self assertThat: marsRover rotatesTo: South afterReceiving: 'rr'.! !

!MarsRoverTests methodsFor: 'mars rover tests' stamp: 'AT 11/18/2021 17:36:58'!
test17RotateLeftFromDirectionSouthChangesDirecionToEast

	self assertThat: marsRover rotatesTo: East afterReceiving: 'rrl'.! !

!MarsRoverTests methodsFor: 'mars rover tests' stamp: 'AT 11/18/2021 17:58:40'!
test18ErrorWhenPathIsASingleInvalidCharacter

	self assertThatMessage: errorMessage appearsAfterTryingToDo: [ marsRover receivePathToFollow: 'x' ].! !

!MarsRoverTests methodsFor: 'mars rover tests' stamp: 'AT 11/18/2021 17:58:40'!
test19ErrorWhenInvalidCharacterIsFoundOnPathSecuence
	
	self assertThatMessage: errorMessage appearsAfterTryingToDo: [ marsRover receivePathToFollow: 'fflxb'. ].! !

!MarsRoverTests methodsFor: 'mars rover tests' stamp: 'AT 11/18/2021 18:12:50'!
test20StopMovingWhenInvalidCharacterIsFoundOnPathSecuence
	
	self do: [marsRover receivePathToFollow: 'fffxbbb'] afterTryingToDo: [self assert: (0 @ 3) equals: marsRover position] .! !

!MarsRoverTests methodsFor: 'mars rover tests' stamp: 'AT 11/18/2021 18:13:27'!
test21StopRotatingWhenInvalidCharacterIsFoundOnPathSecuence
	
	self do: [marsRover receivePathToFollow: 'rrrxlll'] afterTryingToDo: [ 	self assert: West equals: marsRover direction class] .! !


!MarsRoverTests methodsFor: 'tests helpers' stamp: 'AT 11/18/2021 16:27:36'!
assertThat: aShip movesTo: aPosition afterReceiving: aCommandSequence 

	aShip receivePathToFollow: aCommandSequence.
		
	self assert: aPosition equals: aShip position.! !

!MarsRoverTests methodsFor: 'tests helpers' stamp: 'AT 11/18/2021 16:34:00'!
assertThat: aShip rotatesTo: aDirection afterReceiving: aCommandSequence 

	aShip receivePathToFollow: aCommandSequence.
		
	self assert: aDirection equals: aShip direction class.! !

!MarsRoverTests methodsFor: 'tests helpers' stamp: 'AT 11/18/2021 17:58:50'!
assertThatMessage: anErrorMessage appearsAfterTryingToDo: aMovementAction

	self
		should: [ aMovementAction value ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anErrorMessage = anError messageText ].! !

!MarsRoverTests methodsFor: 'tests helpers' stamp: 'AT 11/18/2021 18:11:45'!
do: aMovementAction afterTryingToDo: anInvalidMovementAction

	[aMovementAction value]
	on: Error 
	do: [ 	anInvalidMovementAction ].! !


!classDefinition: #CardinalDirection category: 'MarsRover-Exercise'!
Object subclass: #CardinalDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!CardinalDirection methodsFor: 'Movement Actions' stamp: 'fv 11/15/2021 22:04:19'!
moveBackwards: aShipOnDirection

	self subclassResponsibility ! !

!CardinalDirection methodsFor: 'Movement Actions' stamp: 'fv 11/15/2021 22:04:25'!
moveForward: aShipOnDirection

	self subclassResponsibility ! !

!CardinalDirection methodsFor: 'Movement Actions' stamp: 'fv 11/15/2021 23:08:24'!
rotateLeft: aShipOnDirection

	self subclassResponsibility ! !

!CardinalDirection methodsFor: 'Movement Actions' stamp: 'fv 11/15/2021 23:08:27'!
rotateRight: aShipOnDirection

	self subclassResponsibility ! !


!classDefinition: #East category: 'MarsRover-Exercise'!
CardinalDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!East methodsFor: 'Movement Actions' stamp: 'fv 11/18/2021 13:02:22'!
moveBackwards: aShipOnDirection

	aShipOnDirection movePositionTo: (-1 @ 0)! !

!East methodsFor: 'Movement Actions' stamp: 'fv 11/18/2021 13:02:24'!
moveForward: aShipOnDirection

	aShipOnDirection movePositionTo: (1 @ 0)! !

!East methodsFor: 'Movement Actions' stamp: 'fv 11/18/2021 13:01:36'!
rotateLeft: aShipOnDirection

	aShipOnDirection rotateTo: North new! !

!East methodsFor: 'Movement Actions' stamp: 'fv 11/18/2021 13:01:39'!
rotateRight: aShipOnDirection

	aShipOnDirection rotateTo: South new! !


!classDefinition: #North category: 'MarsRover-Exercise'!
CardinalDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!North methodsFor: 'Movement Actions' stamp: 'fv 11/18/2021 13:02:13'!
moveBackwards: aShipOnDirection

	aShipOnDirection movePositionTo: (0 @ -1)! !

!North methodsFor: 'Movement Actions' stamp: 'fv 11/18/2021 13:02:16'!
moveForward: aShipOnDirection

	aShipOnDirection movePositionTo: (0 @ 1)! !

!North methodsFor: 'Movement Actions' stamp: 'fv 11/18/2021 13:01:42'!
rotateLeft: aShipOnDirection

	aShipOnDirection rotateTo: West new! !

!North methodsFor: 'Movement Actions' stamp: 'fv 11/18/2021 13:01:45'!
rotateRight: aShipOnDirection

	aShipOnDirection rotateTo: East new! !


!classDefinition: #South category: 'MarsRover-Exercise'!
CardinalDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!South methodsFor: 'Movement Actions' stamp: 'fv 11/18/2021 13:02:30'!
moveBackwards: aShipOnDirection

	aShipOnDirection movePositionTo: (0 @ 1)! !

!South methodsFor: 'Movement Actions' stamp: 'fv 11/18/2021 13:02:33'!
moveForward: aShipOnDirection

	aShipOnDirection movePositionTo: (0 @ -1)! !

!South methodsFor: 'Movement Actions' stamp: 'fv 11/18/2021 13:01:47'!
rotateLeft: aShipOnDirection

	aShipOnDirection rotateTo: East new! !

!South methodsFor: 'Movement Actions' stamp: 'fv 11/18/2021 13:01:50'!
rotateRight: aShipOnDirection

	aShipOnDirection rotateTo: West new! !


!classDefinition: #West category: 'MarsRover-Exercise'!
CardinalDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!West methodsFor: 'Movement Actions' stamp: 'fv 11/18/2021 13:02:39'!
moveBackwards: aShipOnDirection

	aShipOnDirection movePositionTo: (1 @ 0)! !

!West methodsFor: 'Movement Actions' stamp: 'fv 11/18/2021 13:02:41'!
moveForward: aShipOnDirection

	aShipOnDirection movePositionTo: (-1 @ 0)! !

!West methodsFor: 'Movement Actions' stamp: 'fv 11/18/2021 13:01:53'!
rotateLeft: aShipOnDirection

	aShipOnDirection rotateTo: South new! !

!West methodsFor: 'Movement Actions' stamp: 'fv 11/18/2021 13:01:56'!
rotateRight: aShipOnDirection

	aShipOnDirection rotateTo: North new! !


!classDefinition: #Command category: 'MarsRover-Exercise'!
Object subclass: #Command
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!Command methodsFor: 'as yet unclassified' stamp: 'fv 11/18/2021 11:57:09'!
moveShip: aShip withDirection: aCardinalDirection

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Command class' category: 'MarsRover-Exercise'!
Command class
	instanceVariableNames: ''!

!Command class methodsFor: 'as yet unclassified' stamp: 'fv 11/17/2021 23:43:32'!
initializeWith: aCommand

	self subclassResponsibility! !

!Command class methodsFor: 'as yet unclassified' stamp: 'AT 11/18/2021 16:18:40'!
with: aCommand

	| newCommand |
	newCommand := Command subclasses detect: [:subclass |( subclass initializeWith: aCommand)].
	^newCommand new.! !


!classDefinition: #BackwardsCommand category: 'MarsRover-Exercise'!
Command subclass: #BackwardsCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!BackwardsCommand methodsFor: 'as yet unclassified' stamp: 'fv 11/18/2021 11:58:00'!
moveShip: aShip withDirection: aCardinalDirection

	aCardinalDirection moveBackwards: aShip! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BackwardsCommand class' category: 'MarsRover-Exercise'!
BackwardsCommand class
	instanceVariableNames: ''!

!BackwardsCommand class methodsFor: 'as yet unclassified' stamp: 'fv 11/17/2021 23:43:54'!
initializeWith: aCommand

	^aCommand = $b! !


!classDefinition: #ForwardCommand category: 'MarsRover-Exercise'!
Command subclass: #ForwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!ForwardCommand methodsFor: 'as yet unclassified' stamp: 'fv 11/18/2021 11:58:17'!
moveShip: aShip withDirection: aCardinalDirection

	aCardinalDirection moveForward: aShip ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ForwardCommand class' category: 'MarsRover-Exercise'!
ForwardCommand class
	instanceVariableNames: ''!

!ForwardCommand class methodsFor: 'as yet unclassified' stamp: 'fv 11/17/2021 23:43:59'!
initializeWith: aCommand

	^aCommand = $f! !


!classDefinition: #LeftCommand category: 'MarsRover-Exercise'!
Command subclass: #LeftCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!LeftCommand methodsFor: 'as yet unclassified' stamp: 'fv 11/18/2021 11:58:31'!
moveShip: aShip withDirection: aCardinalDirection

	aCardinalDirection rotateLeft: aShip! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LeftCommand class' category: 'MarsRover-Exercise'!
LeftCommand class
	instanceVariableNames: ''!

!LeftCommand class methodsFor: 'as yet unclassified' stamp: 'fv 11/17/2021 23:44:05'!
initializeWith: aCommand

	^aCommand = $l! !


!classDefinition: #RightCommand category: 'MarsRover-Exercise'!
Command subclass: #RightCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!RightCommand methodsFor: 'as yet unclassified' stamp: 'fv 11/18/2021 11:58:50'!
moveShip: aShip withDirection: aCardinalDirection

	aCardinalDirection rotateRight: aShip! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RightCommand class' category: 'MarsRover-Exercise'!
RightCommand class
	instanceVariableNames: ''!

!RightCommand class methodsFor: 'as yet unclassified' stamp: 'fv 11/17/2021 23:44:10'!
initializeWith: aCommand

	^aCommand = $r! !


!classDefinition: #MarsRover category: 'MarsRover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'direction position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRover methodsFor: 'initialization' stamp: 'fv 11/17/2021 22:51:36'!
initialize

	direction := North new.
	position := (0 @ 0).! !


!MarsRover methodsFor: 'properties' stamp: 'fv 11/13/2021 12:43:42'!
direction

	^ direction! !

!MarsRover methodsFor: 'properties' stamp: 'fv 11/13/2021 12:43:47'!
position

	^ position! !


!MarsRover methodsFor: 'receive commands' stamp: 'fv 11/18/2021 12:30:34'!
receivePathToFollow: aPathOnString

	| currentCommand |
	aPathOnString do:
		[:singleStringOnPath |
			(self isValidCommand: (singleStringOnPath asString))
				ifTrue: [currentCommand := Command with: singleStringOnPath ]
				ifFalse: [^self error: MarsRover invalidCommandErrorDescription ].
			currentCommand moveShip: self withDirection: direction
		].! !


!MarsRover methodsFor: 'mars rover movements' stamp: 'fv 11/18/2021 12:59:10'!
movePositionTo: aPosition
	
	position := position + aPosition
! !

!MarsRover methodsFor: 'mars rover movements' stamp: 'fv 11/18/2021 12:59:28'!
rotateTo: aCardinalDirection

	direction := aCardinalDirection ! !


!MarsRover methodsFor: 'validation' stamp: 'AT 11/18/2021 16:41:37'!
isValidCommand: aCommand

	| validCommands |
	validCommands := {'f'.'b'.'l'.'r'}.
	
	^validCommands includes: (aCommand asLowercase)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-Exercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'Error Messages' stamp: 'fv 11/14/2021 19:50:31'!
invalidCommandErrorDescription

	^'Invalid Command Error.'! !
