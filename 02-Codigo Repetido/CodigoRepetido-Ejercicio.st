!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'customer book tests' stamp: 'AT 10/13/2021 19:09:36'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	| customerBook customer |

	customerBook := CustomerBook new.
	customer := 'John Lennon'.

	self operation: [ customerBook addCustomer: customer ] doesntTakeMoreThan: (50 * millisecond)! !

!CustomerBookTest methodsFor: 'customer book tests' stamp: 'AT 10/13/2021 19:09:57'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	| customerBook customer |
	
	customerBook := CustomerBook new.
	customer := 'Paul McCartney'.
	
	customerBook addCustomer: customer.

	self operation: [ customerBook removeCustomer: customer ] doesntTakeMoreThan: (100 * millisecond)! !

!CustomerBookTest methodsFor: 'customer book tests' stamp: 'fv 10/12/2021 16:43:19'!
test03CanNotAddACustomerWithEmptyName 
	| customerBook |
			
	customerBook := CustomerBook new.
	
	self onOperation: [ customerBook addCustomer: '' ] 
		manageErrorType: Error
		andGetResult: [ :anError | 			
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'customer book tests' stamp: 'AT 10/13/2021 19:10:08'!
test04CanNotRemoveAnInvalidCustomer
	| customerBook customer |
			
	customerBook := CustomerBook new.
	customer := 'John Lennon'.
	
	customerBook addCustomer: customer.
	
	self onOperation: [ customerBook removeCustomer: 'Paul McCartney' ] 
		manageErrorType: NotFound 
		andGetResult: [ self checkOnCustomerBook: customerBook ifIncludesCustomer: customer ]
! !

!CustomerBookTest methodsFor: 'customer book tests' stamp: 'AT 10/13/2021 19:10:27'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook
	| customerBook customer|
	
	customerBook := CustomerBook new.
	customer := 'Paul McCartney'.
	
	customerBook addCustomer: customer.
	customerBook suspendCustomer: customer.
	
	self activeCustomers: 0 suspendedCustomers: 1 totalCustomers: 1 onCustomerBook: customerBook. 
	self assert: (customerBook includesCustomer: customer).
	

	
! !

!CustomerBookTest methodsFor: 'customer book tests' stamp: 'AT 10/13/2021 19:10:38'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook
	| customerBook customer|
	
	customerBook := CustomerBook new.
	customer := 'Paul McCartney'.
	
	customerBook addCustomer: customer.
	customerBook suspendCustomer: customer.
	customerBook removeCustomer: customer.
	
	self activeCustomers: 0 suspendedCustomers: 0 totalCustomers: 0 onCustomerBook: customerBook .
	self deny: (customerBook includesCustomer: customer).


	
! !

!CustomerBookTest methodsFor: 'customer book tests' stamp: 'AT 10/13/2021 19:10:45'!
test07CanNotSuspendAnInvalidCustomer
	| customerBook customer |
			
	customerBook := CustomerBook new.
	customer := 'John Lennon'.
	
	customerBook addCustomer: customer.
	
	self onOperation: [ customerBook suspendCustomer: 'Ringo Starr' ]
		manageErrorType:  CantSuspend
		andGetResult: [ self checkOnCustomerBook: customerBook ifIncludesCustomer: customer ]! !

!CustomerBookTest methodsFor: 'customer book tests' stamp: 'AT 10/13/2021 19:10:55'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	| customerBook customer |
			
	customerBook := CustomerBook new.
	customer := 'John Lennon'.
	
	customerBook addCustomer: customer.
	customerBook suspendCustomer: customer.

	self onOperation: [ customerBook suspendCustomer: customer ]
		manageErrorType: CantSuspend 
		andGetResult:  [ self checkOnCustomerBook: customerBook ifIncludesCustomer: customer ]! !


!CustomerBookTest methodsFor: 'methods used on customer book tests' stamp: 'AT 10/12/2021 17:12:22'!
activeCustomers: quantityOfActiveCustomers suspendedCustomers: quantityOfSuspendedCustomers totalCustomers: totalCustomers onCustomerBook: customerBook

	self assert: quantityOfActiveCustomers equals: customerBook numberOfActiveCustomers.
	self assert: quantityOfSuspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: totalCustomers equals: customerBook numberOfCustomers.
! !

!CustomerBookTest methodsFor: 'methods used on customer book tests' stamp: 'AT 10/12/2021 17:16:58'!
checkOnCustomerBook: customerBook ifIncludesCustomer: aCustomer

	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomer: aCustomer)! !

!CustomerBookTest methodsFor: 'methods used on customer book tests' stamp: 'fv 10/14/2021 08:51:40'!
onOperation: anOperation manageErrorType: anErrorType andGetResult: aResult

	[ anOperation value. 		
	self fail ]
		on: anErrorType 
		do: aResult! !

!CustomerBookTest methodsFor: 'methods used on customer book tests' stamp: 'fv 10/12/2021 15:36:31'!
operation: anOperation doesntTakeMoreThan: timeLimit
	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	anOperation value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^self assert: millisecondsAfterRunning - millisecondsBeforeRunning < timeLimit! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'initialization' stamp: 'LL 10/30/2020 12:22:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'fv 10/14/2021 08:52:16'!
addCustomer: aCustomerName

	aCustomerName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aCustomerName) or: [ suspended includes: aCustomerName ]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aCustomerName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'fv 10/14/2021 08:52:34'!
removeCustomer: aCustomerName 

	[ active remove: aCustomerName ifAbsent:[ suspended remove: aCustomerName  ] ]
		on: Error
		do:[ ^NotFound signal ].
	^aCustomerName! !

!CustomerBook methodsFor: 'customer management' stamp: 'fv 10/14/2021 08:52:40'!
suspendCustomer: aCustomerName 
	
	(active includes: aCustomerName) ifFalse: [ ^CantSuspend signal ].
	
	active remove: aCustomerName.
	
	suspended add: aCustomerName
! !


!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !


!CustomerBook methodsFor: 'testing' stamp: 'fv 10/9/2021 21:42:10'!
includesCustomer: aCustomerName

	^(active includes: aCustomerName) or: [ suspended includes: aCustomerName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
