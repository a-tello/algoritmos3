!classDefinition: #LimitedOOStackTest category: 'Stack-Exercise'!
TestCase subclass: #LimitedOOStackTest
	instanceVariableNames: 'limitedStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!LimitedOOStackTest methodsFor: 'limited stack test' stamp: 'fv 11/4/2021 18:33:42'!
test01LimitedStackShouldBeEmptyWhenCreated
	
	limitedStack := OOStack with: 3.
	
	self assert: limitedStack isEmpty! !

!LimitedOOStackTest methodsFor: 'limited stack test' stamp: 'fv 11/4/2021 18:37:35'!
test02CanPushValidElementOnLimitedStack
	
	limitedStack := OOStack with: 3.
	
	limitedStack push: 'element'.
	
	self assert: limitedStack size = 1.
	self assert: limitedStack top equals: 'element'.! !

!LimitedOOStackTest methodsFor: 'limited stack test' stamp: 'fv 11/4/2021 18:35:28'!
test03CanNotPushWhenLimitedStackIsFull
	
	limitedStack := OOStack with: 3.
	
	limitedStack push: 'something'.
	limitedStack push: 'test'.
	limitedStack push: 'example'.
	
	self
		should: [ limitedStack push: 'error' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackFullErrorDescription ]! !

!LimitedOOStackTest methodsFor: 'limited stack test' stamp: 'fv 11/4/2021 18:40:10'!
test04CanFindValidPrefixOnLimitedStack

	|  resultList prefixFinder validPrefix |
	
	limitedStack := OOStack with: 3.
	prefixFinder := SentenceFinderByPrefix new.
	validPrefix := Prefix with: 'exa'.

	limitedStack push: 'Example'.
	limitedStack push: 'example'.	
	limitedStack push: 'ex'.
		
	resultList := OrderedCollection new.
	resultList add: 'example'.
	
	self assert: resultList equals: (prefixFinder find: validPrefix in: limitedStack).
	! !


!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'stack test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'stack test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'stack test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'stack test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'stack test' stamp: 'NR 5/13/2020 13:30:48'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'stack test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'stack test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'stack test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'stack test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'stack test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'OOstack prefixFinder prefixWithBlankSpace emptyPrefix validPrefix invalidPrefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests set up' stamp: 'AT 11/4/2021 17:39:45'!
setUp

	OOstack := OOStack new.

	prefixFinder := SentenceFinderByPrefix new.
	
	validPrefix := Prefix with: 'exa'.
	prefixWithBlankSpace := Prefix with: ' '.
	emptyPrefix := Prefix with: ''.! !


!SentenceFinderByPrefixTest methodsFor: 'finder tests' stamp: 'AT 11/4/2021 17:39:36'!
test01FinderReturnsCorrectListWithOnePrefixOnStack
	
	|  resultList |
	
	OOstack push: 'Example'.
	OOstack push: 'example'.	
	OOstack push: 'ex'.
		
	resultList := OrderedCollection new.
	resultList add: 'example'.
	
	
	self assert: resultList equals: (prefixFinder find: validPrefix in: OOstack).
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'finder tests' stamp: 'AT 11/4/2021 18:04:14'!
test02FinderReturnsCorrectListWithTwoPrefixesOnStack
	
	|  resultList |
	
	OOstack push: 'Example'.
	OOstack push: 'example'.	
	OOstack push: 'exAmple'	.
	OOstack push: 'ex'.
	OOstack push: 'example2'.

	resultList := OrderedCollection new.
	resultList add: 'example2'.
	resultList add: 'example'.
	
	
	self assert: resultList equals: (prefixFinder find: validPrefix in: OOstack).
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'finder tests' stamp: 'AT 11/4/2021 18:04:10'!
test03FinderReturnsEmptyStackErrorOnEmptyStack

	self
		should: [ prefixFinder find: validPrefix in: OOstack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'finder tests' stamp: 'AT 11/4/2021 10:36:11'!
test04FinderReturnsInvalidPrefixErrorWithEmptyPrefix

	OOstack push: 'example'.

	self
		should: [ prefixFinder find: emptyPrefix in: OOstack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Prefix prefixInvalidErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'finder tests' stamp: 'AT 11/4/2021 10:36:04'!
test05FinderReturnsInvalidPrefixErrorWithSpaceForPrefix

	OOstack push: 'example'.

	self
		should: [ prefixFinder find: prefixWithBlankSpace in: OOstack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Prefix prefixInvalidErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'finder tests' stamp: 'AT 11/4/2021 18:04:04'!
test06FinderReturnsEmptyListWhenPrefixIsNotFound

	|  resultList |
	
	resultList := OrderedCollection new.

	OOstack push: 'Example'.
	OOstack push: 'exAmple'	.
	OOstack push: 'ex'.

	self assert: resultList equals: (prefixFinder find: validPrefix in: OOstack).
	! !

!SentenceFinderByPrefixTest methodsFor: 'finder tests' stamp: 'fv 11/4/2021 16:50:59'!
test07FinderReturnsInvalidPrefixErrorOnPrefixWithSpaces

	OOstack push: 'example'.
	invalidPrefix := Prefix with: 'e x a'.

	self
		should: [ prefixFinder find: invalidPrefix in: OOstack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Prefix prefixInvalidErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'finder tests' stamp: 'AT 11/4/2021 17:38:17'!
test08StackRemainsTheSameAfterSearchForPrefix
	
	| resultList |
	
	OOstack push: 'Example'.
	OOstack push: 'exAmple'	.
	OOstack push: 'ex'.

	resultList := OrderedCollection new.
	resultList add: 'ex'.
	resultList add: 'exAmple'.
	
	prefixFinder find: validPrefix in: OOstack.

	self assert: (OOstack pop) equals: 'ex'.
	self assert: (OOstack pop) equals: 'exAmple'.
	self assert: (OOstack pop) equals: 'Example'.
		! !

!SentenceFinderByPrefixTest methodsFor: 'finder tests' stamp: 'AT 11/4/2021 17:38:12'!
test09FinderReturnsCorrectListWithCaseSensitivePrefix
	
	|  resultList |
	
	OOstack push: 'Example'.
	OOstack push: 'example'.	

	resultList := OrderedCollection new.
	resultList add: 'example'.
	
	
	self assert: resultList equals: (prefixFinder find: validPrefix in: OOstack).
	
	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stack stackTop'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'AT 11/2/2021 11:18:36'!
initialize

	| newElement |
	
	stack := OrderedCollection new.
	newElement := OOStackEmptyElement new.
	stack add: newElement.
	stackTop := newElement.! !


!OOStack methodsFor: 'stack methods' stamp: 'fv 11/4/2021 17:32:30'!
pop
	
	| removedElement |

	removedElement := stack removeLast value.
	stackTop := stack at: (stack size).
	
	^removedElement ! !

!OOStack methodsFor: 'stack methods' stamp: 'AT 11/2/2021 11:32:56'!
push: aValue

	| newElement |
	
	newElement := OOStackNonEmptyElement new initializeWith: aValue. 
	stack add: newElement.
	stackTop := newElement.! !

!OOStack methodsFor: 'stack methods' stamp: 'AT 11/2/2021 11:23:40'!
top 

	^stackTop value! !


!OOStack methodsFor: 'stack properties' stamp: 'AT 11/2/2021 11:21:24'!
isEmpty

	^self size = 0! !

!OOStack methodsFor: 'stack properties' stamp: 'AT 11/2/2021 10:59:47'!
size

	^stack count: [:anElement | (anElement isNonEmpty) ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !

!OOStack class methodsFor: 'error descriptions' stamp: 'AT 11/4/2021 11:28:46'!
stackFullErrorDescription
	
	^ 'Stack is full'! !


!OOStack class methodsFor: 'instance creation' stamp: 'AT 11/4/2021 12:22:27'!
with: sizeLimit

	^LimitedOOStack new initializeWith: sizeLimit.
	! !


!classDefinition: #LimitedOOStack category: 'Stack-Exercise'!
OOStack subclass: #LimitedOOStack
	instanceVariableNames: 'maxSize'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!LimitedOOStack methodsFor: 'stack properties' stamp: 'AT 11/4/2021 11:30:33'!
isFull
	(maxSize = self size) ifTrue: [^self error: OOStack stackFullErrorDescription].
! !


!LimitedOOStack methodsFor: 'stack methods' stamp: 'AT 11/4/2021 12:24:43'!
push: aValue

	| newElement |
	
	self isFull.
		
	newElement := OOStackNonEmptyElement new initializeWith: aValue. 
	stack add: newElement.
	stackTop := newElement.! !


!LimitedOOStack methodsFor: 'initialization' stamp: 'AT 11/4/2021 12:06:24'!
initializeWith: sizeLimit

	maxSize := sizeLimit! !


!classDefinition: #OOStackElement category: 'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'stack element properties' stamp: 'AT 11/2/2021 08:48:54'!
isNonEmpty

	self subclassResponsibility ! !

!OOStackElement methodsFor: 'stack element properties' stamp: 'AT 11/2/2021 10:29:56'!
value

	self subclassResponsibility ! !


!OOStackElement methodsFor: 'stack element methods' stamp: 'AT 11/1/2021 20:50:22'!
pop

	self subclassResponsibility ! !

!OOStackElement methodsFor: 'stack element methods' stamp: 'AT 11/1/2021 20:41:18'!
top 
	
	^value! !


!OOStackElement methodsFor: 'initialization' stamp: 'fv 11/3/2021 15:03:44'!
initialize

	value := OOStack stackEmptyErrorDescription ! !


!classDefinition: #OOStackEmptyElement category: 'Stack-Exercise'!
OOStackElement subclass: #OOStackEmptyElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackEmptyElement methodsFor: 'stack element properties' stamp: 'AT 11/2/2021 09:40:50'!
isNonEmpty

	^false! !

!OOStackEmptyElement methodsFor: 'stack element properties' stamp: 'AT 11/2/2021 10:30:17'!
value

	^self error: OOStack stackEmptyErrorDescription! !


!OOStackEmptyElement methodsFor: 'initialization' stamp: 'AT 11/2/2021 10:52:56'!
initialize 

	value := OOStack stackEmptyErrorDescription ! !


!classDefinition: #OOStackNonEmptyElement category: 'Stack-Exercise'!
OOStackElement subclass: #OOStackNonEmptyElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNonEmptyElement methodsFor: 'stack element properties' stamp: 'AT 11/2/2021 09:40:58'!
isNonEmpty

	^true! !

!OOStackNonEmptyElement methodsFor: 'stack element properties' stamp: 'AT 11/2/2021 10:29:00'!
value

	^value! !


!OOStackNonEmptyElement methodsFor: 'initialization' stamp: 'AT 11/2/2021 10:07:26'!
initializeWith: aValue

	value := aValue 
! !


!classDefinition: #Prefix category: 'Stack-Exercise'!
Object subclass: #Prefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Prefix methodsFor: 'prefix properties' stamp: 'fv 11/4/2021 01:07:49'!
isValid

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Prefix class' category: 'Stack-Exercise'!
Prefix class
	instanceVariableNames: ''!

!Prefix class methodsFor: 'as yet unclassified' stamp: 'AT 11/4/2021 10:35:38'!
prefixInvalidErrorDescription
	
	^ 'Prefix is invalid'! !

!Prefix class methodsFor: 'as yet unclassified' stamp: 'fv 11/4/2021 16:46:08'!
with: aPrefix
	
	((aPrefix = '') or: [aPrefix includesSubString: ' ']) ifTrue: [^InvalidPrefix new].
	^ValidPrefix new initializeWith: aPrefix! !


!classDefinition: #InvalidPrefix category: 'Stack-Exercise'!
Prefix subclass: #InvalidPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!InvalidPrefix methodsFor: 'invalid prefix properties' stamp: 'fv 11/4/2021 16:45:49'!
isValid	

	^self error: Prefix prefixInvalidErrorDescription
	! !


!classDefinition: #ValidPrefix category: 'Stack-Exercise'!
Prefix subclass: #ValidPrefix
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ValidPrefix methodsFor: 'valid prefix properties' stamp: 'fv 11/4/2021 01:09:28'!
isValid

	^true! !

!ValidPrefix methodsFor: 'valid prefix properties' stamp: 'fv 11/4/2021 01:11:22'!
value

	^value! !


!ValidPrefix methodsFor: 'initialization' stamp: 'fv 11/4/2021 01:11:37'!
initializeWith: aPrefix

	value := aPrefix! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'finder methods' stamp: 'fv 11/4/2021 18:26:45'!
find: aPrefix in: aStack
	
	| newStackCoincidences each reverseStack |
	
	aPrefix isValid.
	(aStack isEmpty) ifTrue: [ ^self error: OOStack stackEmptyErrorDescription ].

	newStackCoincidences := OrderedCollection new.
	reverseStack := OOStack new.

	[aStack isEmpty] whileFalse: [(each := aStack pop). 
		(each beginsWith: aPrefix value) ifTrue: [newStackCoincidences add: each].
		reverseStack push: each].
	
	[reverseStack isEmpty] whileFalse: [(each := reverseStack pop). 
		aStack push: each].
	
	^newStackCoincidences 
! !
