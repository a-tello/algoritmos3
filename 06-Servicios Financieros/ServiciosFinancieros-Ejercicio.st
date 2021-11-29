!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'mainPortfolio account portfolioToAdd account2 account3 errorMessage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'AT 11/29/2021 16:21:29'!
test01PortfolioWithoutAccountsHasZeroAsBalance 

	self assert: 0 equals: mainPortfolio balance
! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'AT 11/29/2021 16:29:19'!
test02AddAnEmptyReceptiveAccountNotIncreasesBalanceOnPortfolio 

	mainPortfolio add: account.
	
	self assert: 1 equals: mainPortfolio numberAccounts.
	self assert: 0 equals: mainPortfolio balance.
! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'AT 11/29/2021 16:36:13'!
test03AddAReceptiveAccountWithTransactionsIncreasesBalanceOnPortfolio 

	Deposit register: 100 * peso on: account.
	mainPortfolio add: account.
		
	self assert: 100*peso equals: mainPortfolio balance.
! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'AT 11/29/2021 16:36:21'!
test04AddMultipleReceptiveAccountsWithTransactionsChangeBalanceOnPortfolio 

	Deposit register: 100 * peso on: account.
	Deposit register: 300 * peso on: account2 .
	
	Withdraw register: 50 * peso on: account3.
	
	mainPortfolio add: account.
	mainPortfolio add: account2.
	mainPortfolio add: account3.
		
	self assert: 350*peso equals: mainPortfolio balance.
! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'AT 11/29/2021 16:30:56'!
test05AddAnEmptyPortfolioDoesntChangeBalanceOnPortfolio 

	mainPortfolio add: portfolioToAdd .
	
	self assert: 0 equals: mainPortfolio balance.
! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'AT 11/29/2021 16:30:56'!
test06AddAPortfolioWithNonEmptyAccountsChangesBalanceOnPortfolio 
	
	
	Deposit register: 100*peso on: account.
	portfolioToAdd add: account .
	
	mainPortfolio add: portfolioToAdd .
	
	self assert: 100*peso equals: mainPortfolio balance.
! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'AT 11/29/2021 16:36:50'!
test07AddAccountsAndPortfoliosChangesBalanceOnPortfolio

	Deposit register: 100*peso on: account.
	portfolioToAdd add: account.
	mainPortfolio add: portfolioToAdd.
	
	Deposit register: 200*peso on: account2.
	mainPortfolio add: account2.
	
	self assert: 300*peso equals: mainPortfolio balance.
! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'AT 11/29/2021 16:36:46'!
test08PortfolioKnowsTransactionOfRegisteredAccount

	| deposit |
	
	deposit := Deposit register: 100 * peso on: account.

	mainPortfolio add: account.
		
	self assert: (mainPortfolio hasRegistered: deposit)
! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'AT 11/29/2021 16:30:56'!
test09PortfolioKnowsTransactionOfRegisteredPortfolio

	|  deposit |
	
	deposit := Deposit register: 100 * peso on: account.
	
	portfolioToAdd add: account .
	mainPortfolio add: portfolioToAdd .
	
	self assert: (mainPortfolio hasRegistered: deposit)
! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'AT 11/29/2021 16:29:19'!
test10PortfolioDoesntKnowTransactionOfANonRegisteredAccount

	|  deposit |
	
	deposit := Deposit register: 100 * peso on: account.
		
	self deny: (mainPortfolio hasRegistered: deposit)
! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'AT 11/29/2021 16:37:35'!
test11PortfolioKnowsAllTransactionsOfRegisteredAccountsAndPortfolios

	|  transactions deposit anotherDeposit withdraw |
	
	deposit := Deposit register: 100 * peso on: account.
	anotherDeposit := Deposit register: 200*peso on: account2 .
	withdraw := Withdraw register: 200*peso on: account3 .
	
	portfolioToAdd add: account3 .
	
	mainPortfolio add: account .
	mainPortfolio add: account2 .
	mainPortfolio add: portfolioToAdd .
	
	transactions := OrderedCollection with: deposit with:anotherDeposit with:withdraw .
	
	self assert: transactions equals: mainPortfolio transactions .
! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'AT 11/29/2021 17:35:24'!
test12ErrorMessageWhenTryingToAddSameAccountTwice

	mainPortfolio add: account.
	
	self assertThatErrorMessageIsThrownAfterTryingToDo: [	mainPortfolio add: account.]! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'AT 11/29/2021 17:34:43'!
test13ErrorMessageWhenTryingToAddAnAccountAddedToAPortfolioAlreadyAdded

	portfolioToAdd add: account.
	mainPortfolio add: portfolioToAdd. 
	
	self assertThatErrorMessageIsThrownAfterTryingToDo: [	mainPortfolio add: account].
! !

!PortfolioTest methodsFor: 'portfolio tests' stamp: 'AT 11/29/2021 17:35:09'!
test14ErrorMessageWhenTryingToAddPortfolioToItself

	self assertThatErrorMessageIsThrownAfterTryingToDo: [	mainPortfolio add: mainPortfolio].! !


!PortfolioTest methodsFor: 'test helpers' stamp: 'AT 11/29/2021 17:34:58'!
assertThatErrorMessageIsThrownAfterTryingToDo: anAccountRegistration

	self should: [	anAccountRegistration value]
		raise: Error 
		withExceptionDo: [:anError |
			self assert: anError messageText = errorMessage ].! !


!PortfolioTest methodsFor: 'setUp' stamp: 'AT 11/29/2021 17:32:48'!
setUp

	mainPortfolio := Portfolio new.
	portfolioToAdd := Portfolio new.
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	
	errorMessage := Portfolio canNotAddSameAccountTwice .
	
	! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AT 11/29/2021 16:04:03'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'tests' stamp: 'fv 11/29/2021 17:07:47'!
test01AfterATransferOriginAccountIncresesBalanceAndDestinationAccountDecresesBalance

	| originAccount destinationAccount |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	Transfer from: originAccount to: destinationAccount forAnAmountOf: (1000 * peso).
	
	self assert: (1000 * peso) equals: destinationAccount balance.
	self assert: (-1000 * peso) equals: originAccount balance.! !

!TransferTest methodsFor: 'tests' stamp: 'AT 11/29/2021 16:44:40'!
test02TransferKnowsItsValue

	| originAccount destinationAccount transferAmount transfer |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	transferAmount := 100 * peso.
	
	transfer := Transfer from: originAccount to: destinationAccount forAnAmountOf: transferAmount.
	
	self assert: transferAmount equals: transfer value. ! !

!TransferTest methodsFor: 'tests' stamp: 'fv 11/29/2021 17:17:49'!
test03ErrorMessageIfTransferValueIsZero

	self assertErrorMessageForInvalidTransferValue: 0! !

!TransferTest methodsFor: 'tests' stamp: 'fv 11/29/2021 17:18:04'!
test04ErrorMessageIfTransferValueIsNegative

	self assertErrorMessageForInvalidTransferValue: -100! !

!TransferTest methodsFor: 'tests' stamp: 'AT 11/29/2021 16:45:43'!
test05ErrorMessageWhenTryingToTransferToTheSameAccount

	| originAccount transferAmount transfer |
	originAccount := ReceptiveAccount new.
	transferAmount := 100 * peso.
		
	transfer := [Transfer from: originAccount to: originAccount forAnAmountOf: transferAmount].
	
	self
		should: [ transfer value ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: Transfer transferCanNotBeBetweenTheSameAccountErrorDescription = anError messageText ].

	! !

!TransferTest methodsFor: 'tests' stamp: 'AT 11/29/2021 16:45:59'!
test06TransferWithdrawLegKnowsDeposit

	| originAccount destinationAccount transferAmount transfer |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	transferAmount := 100 * peso.
	
	transfer := Transfer from: originAccount to: destinationAccount forAnAmountOf: transferAmount.
	
	self assert: transfer deposit equals: transfer withdraw counterPart .! !

!TransferTest methodsFor: 'tests' stamp: 'AT 11/29/2021 16:46:14'!
test07TransferDepositLegKnowsWithdraw

	| originAccount destinationAccount transferAmount transfer |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	transferAmount := 100 * peso.
	
	transfer := Transfer from: originAccount to: destinationAccount forAnAmountOf: transferAmount.
	
	self assert: transfer withdraw equals: transfer deposit counterPart ! !


!TransferTest methodsFor: 'helpers' stamp: 'fv 11/29/2021 17:17:28'!
assertErrorMessageForInvalidTransferValue: aValue

	| originAccount destinationAccount |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	self
		should: [ Transfer from: originAccount to: destinationAccount forAnAmountOf: aValue. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: Transfer transferCanNotBeNegativeOrZeroErrorDescription = anError messageText ].! !


!classDefinition: #Account category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Account methodsFor: 'main protocol' stamp: 'AT 11/29/2021 15:45:20'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'AT 11/29/2021 15:46:00'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'AT 11/29/2021 16:04:57'!
includes: anAccount

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'AT 11/29/2021 15:46:28'!
transactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'AT 11/29/2021 15:56:53'!
initialize

	accounts := OrderedCollection new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'fv 11/29/2021 17:14:29'!
add: anAccount
	
	self assertThatAccountIsNotDuplicate: anAccount .
	accounts add: anAccount 
! !

!Portfolio methodsFor: 'main protocol' stamp: 'AT 11/29/2021 15:56:28'!
balance

	^accounts sum: [:anElement | anElement balance] ifEmpty:[0].! !

!Portfolio methodsFor: 'main protocol' stamp: 'AT 11/29/2021 15:57:03'!
hasRegistered: aTransaction
	
	^accounts anySatisfy: [ :anElement | (anElement hasRegistered: aTransaction)].
	! !

!Portfolio methodsFor: 'main protocol' stamp: 'AT 11/29/2021 15:56:48'!
transactions 
	| transactionsList |
	transactionsList := OrderedCollection new.
	
	accounts do:[:anElement | transactionsList addAll: (anElement transactions)].
	^transactionsList ! !


!Portfolio methodsFor: 'validation' stamp: 'fv 11/29/2021 17:14:13'!
assertThatAccountIsNotDuplicate: anAccount

	((self isSameAccount: anAccount)or: [self includesTo: anAccount])ifTrue: [self error: Portfolio canNotAddSameAccountTwice].! !

!Portfolio methodsFor: 'validation' stamp: 'AT 11/29/2021 16:12:00'!
isSameAccount: anAccount

	^self = anAccount! !


!Portfolio methodsFor: 'private' stamp: 'AT 11/29/2021 16:04:19'!
includes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'private' stamp: 'AT 11/29/2021 16:17:32'!
includesTo: anAccount

	^accounts anySatisfy: [:element | element includes: anAccount ]! !

!Portfolio methodsFor: 'private' stamp: 'AT 11/29/2021 15:56:45'!
numberAccounts

	^accounts size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 09:56:18'!
canNotAddSameAccountTwice

	^'No se puede agregar una cuenta dos veces al mismo portfolio'! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'AT 11/29/2021 08:37:34'!
balance

	^transactions inject:0 into: [ :partialResult :aTransaction |  aTransaction affectBalance: partialResult ].! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'AT 11/29/2021 16:03:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'AT 11/25/2021 13:19:55'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private' stamp: 'AT 11/29/2021 16:03:09'!
includes: anAccount

	^self = anAccount! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 08:58:14'!
affectBalance: partialBalance
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'fv 11/25/2021 19:31:43'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 08:38:33'!
affectBalance: partialBalance
	
	^partialBalance + self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferLeg methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 16:06:22'!
affectBalance: partialBalance
	
	self subclassResponsibility ! !

!TransferLeg methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 16:06:26'!
counterPart

	self subclassResponsibility ! !


!TransferLeg methodsFor: 'initialization' stamp: 'AT 11/29/2021 16:06:29'!
initializeFor: aTransfer

	self subclassResponsibility ! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Ejercicio'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferDepositLeg methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 08:39:02'!
affectBalance: partialBalance
	
	^partialBalance + transfer value! !

!TransferDepositLeg methodsFor: 'as yet unclassified' stamp: 'AT 11/23/2021 09:32:39'!
counterPart

	^transfer withdraw .! !


!TransferDepositLeg methodsFor: 'initialization' stamp: 'fv 11/25/2021 19:33:03'!
initializeFor: aTransfer

	transfer := aTransfer ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDepositLeg class' category: 'ServiciosFinancieros-Ejercicio'!
TransferDepositLeg class
	instanceVariableNames: ''!

!TransferDepositLeg class methodsFor: 'instance creation' stamp: 'fv 11/25/2021 19:30:34'!
for: aTransfer

	^ self new initializeFor: aTransfer ! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Ejercicio'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferWithdrawLeg methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 08:50:13'!
affectBalance: partialBalance
	
	^partialBalance - transfer value! !

!TransferWithdrawLeg methodsFor: 'as yet unclassified' stamp: 'AT 11/23/2021 09:32:53'!
counterPart

	^transfer deposit.! !


!TransferWithdrawLeg methodsFor: 'initialization' stamp: 'fv 11/25/2021 19:33:08'!
initializeFor: aTransfer

	transfer := aTransfer ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdrawLeg class' category: 'ServiciosFinancieros-Ejercicio'!
TransferWithdrawLeg class
	instanceVariableNames: ''!

!TransferWithdrawLeg class methodsFor: 'instance creation' stamp: 'fv 11/25/2021 19:30:45'!
for: aTransfer

	^ self new initializeFor: aTransfer ! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 08:50:05'!
affectBalance: partialBalance
	
	^partialBalance - self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value deposit withdraw'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'AT 11/21/2021 15:17:30'!
deposit

	^deposit! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'AT 11/20/2021 21:49:13'!
value

	^value! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'AT 11/21/2021 15:17:37'!
withdraw

	^withdraw! !


!Transfer methodsFor: 'initialization' stamp: 'AT 11/21/2021 15:11:11'!
initializeWith: aValue aDeposit: aTransferDeposit aWithdraw: aTransferWithdraw.

	value := aValue.
	deposit := aTransferDeposit.
	withdraw := aTransferWithdraw .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'fv 11/25/2021 19:36:55'!
from: anOriginAccount to: aDestinationAccount forAnAmountOf: aValue 
	
	| deposit withdraw transfer |
	
	self assertThatTransferIsValidBetween: anOriginAccount and: aDestinationAccount.
	self assertThatTransferAmountIsValid: aValue .
	
	transfer := self new.
	
	withdraw := TransferWithdrawLeg register: transfer on: anOriginAccount.
	deposit := TransferDepositLeg  register: transfer on: aDestinationAccount.
	
	^transfer initializeWith: aValue aDeposit: deposit aWithdraw: withdraw.! !


!Transfer class methodsFor: 'validation' stamp: 'AT 11/23/2021 11:26:29'!
assertThatTransferAmountIsValid: aValue 
	
	(aValue <= 0) ifTrue: [self error: self transferCanNotBeNegativeOrZeroErrorDescription].! !

!Transfer class methodsFor: 'validation' stamp: 'AT 11/29/2021 16:48:10'!
assertThatTransferIsValidBetween: anOriginAccount and: aDestinationAccount
	
	(anOriginAccount = aDestinationAccount) ifTrue:[^self error: self transferCanNotBeBetweenTheSameAccountErrorDescription].! !


!Transfer class methodsFor: 'error messages' stamp: 'AT 11/29/2021 16:48:59'!
transferCanNotBeBetweenTheSameAccountErrorDescription

	^'Transfer destination account must be different from origin account'.

	! !

!Transfer class methodsFor: 'error messages' stamp: 'AT 11/29/2021 16:49:06'!
transferCanNotBeNegativeOrZeroErrorDescription

	^'Transfer value must be positive'! !
