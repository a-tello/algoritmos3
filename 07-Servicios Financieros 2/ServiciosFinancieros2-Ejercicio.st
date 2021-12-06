!classDefinition: #AccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #AccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!


!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
AccountTest subclass: #PortfolioTest
	instanceVariableNames: 'mainPortfolio account portfolioToAdd account2 account3'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AT 12/5/2021 11:12:23'!
setUp

	mainPortfolio := Portfolio new.
	portfolioToAdd := Portfolio new.
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 16:21:29'!
test01PortfolioWithoutAccountsHasZeroAsBalance 

	self assert: 0 equals: mainPortfolio balance
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 16:29:19'!
test02AddAnEmptyReceptiveAccountNotIncreasesBalanceOnPortfolio 

	mainPortfolio add: account.
	
	self assert: 1 equals: mainPortfolio numberAccounts.
	self assert: 0 equals: mainPortfolio balance.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 16:36:13'!
test03AddAReceptiveAccountWithTransactionsIncreasesBalanceOnPortfolio 

	Deposit register: 100 * peso on: account.
	mainPortfolio add: account.
		
	self assert: 100*peso equals: mainPortfolio balance.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 16:36:21'!
test04AddMultipleReceptiveAccountsWithTransactionsChangeBalanceOnPortfolio 

	Deposit register: 100 * peso on: account.
	Deposit register: 300 * peso on: account2 .
	
	Withdraw register: 50 * peso on: account3.
	
	mainPortfolio add: account.
	mainPortfolio add: account2.
	mainPortfolio add: account3.
		
	self assert: 350*peso equals: mainPortfolio balance.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 16:30:56'!
test05AddAnEmptyPortfolioDoesntChangeBalanceOnPortfolio 

	mainPortfolio add: portfolioToAdd .
	
	self assert: 0 equals: mainPortfolio balance.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 16:30:56'!
test06AddAPortfolioWithNonEmptyAccountsChangesBalanceOnPortfolio 
	
	
	Deposit register: 100*peso on: account.
	portfolioToAdd add: account .
	
	mainPortfolio add: portfolioToAdd .
	
	self assert: 100*peso equals: mainPortfolio balance.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 16:36:50'!
test07AddAccountsAndPortfoliosChangesBalanceOnPortfolio

	Deposit register: 100*peso on: account.
	portfolioToAdd add: account.
	mainPortfolio add: portfolioToAdd.
	
	Deposit register: 200*peso on: account2.
	mainPortfolio add: account2.
	
	self assert: 300*peso equals: mainPortfolio balance.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 16:36:46'!
test08PortfolioKnowsTransactionOfRegisteredAccount

	| deposit |
	
	deposit := Deposit register: 100 * peso on: account.

	mainPortfolio add: account.
		
	self assert: (mainPortfolio hasRegistered: deposit)
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 16:30:56'!
test09PortfolioKnowsTransactionOfRegisteredPortfolio

	|  deposit |
	
	deposit := Deposit register: 100 * peso on: account.
	
	portfolioToAdd add: account .
	mainPortfolio add: portfolioToAdd .
	
	self assert: (mainPortfolio hasRegistered: deposit)
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 16:29:19'!
test10PortfolioDoesntKnowTransactionOfANonRegisteredAccount

	|  deposit |
	
	deposit := Deposit register: 100 * peso on: account.
		
	self deny: (mainPortfolio hasRegistered: deposit)
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 16:37:35'!
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

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'fv 11/29/2021 17:09:16'!
test12ErrorMessageWhenTryingToAddSameAccountTwice

	mainPortfolio add: account.
	
	self should: [	mainPortfolio add: account.]
		raise: Error 
		withExceptionDo: [:anError |
			self assert: anError messageText = Portfolio canNotAddSameAccountTwice].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'fv 11/29/2021 17:10:04'!
test13ErrorMessageWhenTryingToAddAnAccountAddedToAPortfolioAlreadyAdded

	portfolioToAdd add: account.
	mainPortfolio add: portfolioToAdd. 
	
	self should: [	mainPortfolio add: account.]
		raise: Error 
		withExceptionDo: [:anError |
			self assert: anError messageText = Portfolio canNotAddSameAccountTwice].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'fv 11/29/2021 17:11:02'!
test14ErrorMessageWhenTryingToAddPortfolioToItself

	self should: [	mainPortfolio add: mainPortfolio .]
		raise: Error 
		withExceptionDo: [:anError |
			self assert: anError messageText = Portfolio canNotAddSameAccountTwice].! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
AccountTest subclass: #ReceptiveAccountTest
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


!classDefinition: #BankReportTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #BankReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!


!classDefinition: #AccountSummaryTest category: 'ServiciosFinancieros-Ejercicio'!
BankReportTest subclass: #AccountSummaryTest
	instanceVariableNames: 'account secondaryAccount portfolio receptiveAccountSummaryy portfolioSummary summaryToMatch'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountSummaryTest methodsFor: 'SetUp' stamp: 'AT 12/6/2021 09:08:22'!
setUp

	account := ReceptiveAccount new.
	secondaryAccount := ReceptiveAccount new.
	portfolio := Portfolio new.
	receptiveAccountSummaryy := AccountSummary of: account .
	portfolioSummary := AccountSummary of:portfolio .
	summaryToMatch := OrderedCollection new.
	

	! !


!AccountSummaryTest methodsFor: 'tests' stamp: 'AT 12/6/2021 09:08:04'!
test01AccountWithNoTransactionsHasSummaryOfZeroBalance

	summaryToMatch add: 'Balance = 0 pesos'.
	
	self assert: receptiveAccountSummaryy summary equals: summaryToMatch.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AT 12/6/2021 09:11:54'!
test02AccountWithADepositShowsDepositAndCorrectBalanceOnSummary

	Deposit register: 100 * peso on: account.
	
	summaryToMatch add: 'Deposito por 100 pesos';
					add: 'Balance = 100 pesos'.
	
	self assert: receptiveAccountSummaryy summary equals: summaryToMatch.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AT 12/6/2021 09:11:48'!
test03AccountWithAWithdrawShowsWithdrawAndCorrectBalanceOnSummary

	Withdraw register: 100 * peso on: account.
	
	summaryToMatch add: 'Extraccion por 100 pesos';
					add: 'Balance = -100 pesos'.
	
	self assert: receptiveAccountSummaryy summary equals: summaryToMatch.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AT 12/6/2021 09:11:43'!
test04AccountWithDepositTransferShowsTransferAndCorrectBalanceOnSummary

	Transfer from: secondaryAccount to: account forAnAmountOf: 100 * peso.
	
	summaryToMatch add: 'Entrada por transferencia de 100 pesos';
					 add: 'Balance = 100 pesos'.
	
	self assert: receptiveAccountSummaryy summary equals: summaryToMatch.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AT 12/6/2021 09:11:33'!
test05AccountWithWithdrawTransferShowsTransferAndCorrectBalanceOnSummary

	Transfer from: account to: secondaryAccount forAnAmountOf: 100 * peso.
	
	summaryToMatch add: 'Salida por transferencia de 100 pesos';
					add: 'Balance = -100 pesos'.
	
	self assert: receptiveAccountSummaryy summary equals: summaryToMatch.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AT 12/6/2021 09:11:27'!
test06AccountWithMultipleDepositsShowsCorrectListOfTransactionsOnSummary

	Deposit register: 10 * peso on: account.
	Deposit register: 80 * peso on: account.
	
	summaryToMatch add: 'Deposito por 10 pesos';
					add: 'Deposito por 80 pesos';
					add: 'Balance = 90 pesos'.
	
	self assert: receptiveAccountSummaryy summary equals: summaryToMatch.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AT 12/6/2021 09:11:20'!
test07AccountWithDepositAndWithdrawShowsCorrectListOfTransactionsOnSummary

	Deposit register: 10 * peso on: account.
	Withdraw register: 80 * peso on: account.
	
	summaryToMatch add: 'Deposito por 10 pesos';
					add: 'Extraccion por 80 pesos';
					add: 'Balance = -70 pesos'.
	
	self assert: receptiveAccountSummaryy summary equals: summaryToMatch.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AT 12/6/2021 09:11:12'!
test08AccountWithTransactionsAndTransfersShowsCorrectListOfTransactionsOnSummary

	Deposit register: 10 * peso on: account.
	Withdraw register: 80 * peso on: account.
	Transfer from: secondaryAccount to: account forAnAmountOf: 100 * peso.
	
	summaryToMatch add: 'Deposito por 10 pesos';
					add: 'Extraccion por 80 pesos';
					add: 'Entrada por transferencia de 100 pesos';
					add: 'Balance = 30 pesos'.
	
	self assert: receptiveAccountSummaryy summary equals: summaryToMatch.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AT 12/6/2021 09:11:05'!
test09AccountWithTransactionsAndTransfersShowsZeroBalanceOnSummary

	Deposit register: 10 * peso on: account.
	Withdraw register: 80 * peso on: account.
	Transfer from: secondaryAccount to: account forAnAmountOf: 70 * peso.
	
	summaryToMatch add: 'Deposito por 10 pesos';
					add: 'Extraccion por 80 pesos';
					add: 'Entrada por transferencia de 70 pesos';
					add: 'Balance = 0 pesos'.
	
	self assert: receptiveAccountSummaryy summary equals: summaryToMatch.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AT 12/6/2021 09:11:01'!
test10PortfolioWithNoTransactionsShowsZeroBalanceOnSummary

	portfolio add: account .
	summaryToMatch add: 'Balance = 0 pesos'.
	
	self assert: portfolioSummary summary equals: summaryToMatch.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AT 12/6/2021 09:10:53'!
test11PortfolioWithADepositShowsDepositAndCorrectBalanceOnSummary

	Deposit register: 100 * peso on: account.
	
	portfolio add: account .
	
	summaryToMatch add: 'Deposito por 100 pesos';
					add: 'Balance = 100 pesos'.
	
	self assert: portfolioSummary summary equals: summaryToMatch.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AT 12/6/2021 09:10:42'!
test12PortfolioWithTransactionsShowsFullReportOnSummary

	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
	Transfer from: secondaryAccount to: account forAnAmountOf: 100 * peso.
	Transfer from: account to: secondaryAccount forAnAmountOf: 100 * peso.
	
	portfolio add: account .
	
	summaryToMatch add: 'Deposito por 100 pesos';
					add: 'Extraccion por 50 pesos';
					add: 'Entrada por transferencia de 100 pesos';
					add: 'Salida por transferencia de 100 pesos';
					add: 'Balance = 50 pesos'.
	
	self assert: portfolioSummary summary equals: summaryToMatch.! !


!classDefinition: #TransferNetTest category: 'ServiciosFinancieros-Ejercicio'!
BankReportTest subclass: #TransferNetTest
	instanceVariableNames: 'accountt seconddaryAccount portfolioo portfolioTransferNet transferNett reportToMatchh'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferNetTest methodsFor: 'setUp' stamp: 'AT 12/6/2021 09:20:49'!
setUp

	accountt := ReceptiveAccount new.
	seconddaryAccount := ReceptiveAccount new.
	portfolioo := Portfolio new.
	transferNett := TransferNet of: accountt.
	portfolioTransferNet := TransferNet of:portfolioo.
	reportToMatchh := OrderedCollection new.! !


!TransferNetTest methodsFor: 'tests' stamp: 'AT 12/6/2021 09:16:03'!
test01AccountWithNoTranfersShowsZeroReport

	reportToMatchh add: 'Neto de Transferencias = 0 pesos'.
	
	self assert: transferNett report equals: reportToMatchh.! !

!TransferNetTest methodsFor: 'tests' stamp: 'AT 12/6/2021 09:21:04'!
test02AccountWithDepositTransferShowsCorrectReport

	Transfer from: seconddaryAccount to: accountt forAnAmountOf: 100 * peso.
	reportToMatchh add: 'Neto de Transferencias = 100 pesos'.
	
	self assert: transferNett report equals: reportToMatchh.! !

!TransferNetTest methodsFor: 'tests' stamp: 'AT 12/6/2021 09:21:18'!
test03AccountWithWithdrawTransferShowsCorrectReport

	Transfer from: accountt to: seconddaryAccount forAnAmountOf: 100 * peso.
	reportToMatchh add: 'Neto de Transferencias = -100 pesos'.
	
	self assert: transferNett report equals: reportToMatchh.! !

!TransferNetTest methodsFor: 'tests' stamp: 'AT 12/6/2021 09:21:29'!
test04AccountWithDepositAndWithdrawTransfersShowsCorrectReport

	Transfer from: accountt to: seconddaryAccount forAnAmountOf: 100 * peso.
	Transfer from: seconddaryAccount to: accountt forAnAmountOf: 50 * peso.
	reportToMatchh add: 'Neto de Transferencias = -50 pesos'.
	
	self assert: transferNett report equals: reportToMatchh.! !

!TransferNetTest methodsFor: 'tests' stamp: 'AT 12/6/2021 09:21:39'!
test05AccountWithTransactionsAndTransfersShowsCorrectReport

	Deposit register: 100 * peso on: accountt.
	Withdraw register: 20 * peso on: accountt.
	Transfer from: accountt to: seconddaryAccount forAnAmountOf: 100 * peso.
	Transfer from: seconddaryAccount to: accountt forAnAmountOf: 50 * peso.
	reportToMatchh add: 'Neto de Transferencias = -50 pesos'.
	
	self assert: transferNett report equals: reportToMatchh.! !

!TransferNetTest methodsFor: 'tests' stamp: 'AT 12/6/2021 09:21:57'!
test06PortfolioWithNoTranfersShowsZeroReport

	portfolioo add: accountt.
	reportToMatchh add: 'Neto de Transferencias = 0 pesos'.
	
	self assert: portfolioTransferNet report equals: reportToMatchh.! !

!TransferNetTest methodsFor: 'tests' stamp: 'AT 12/6/2021 09:22:18'!
test07PortfolioWithTransactionsAndTransfersShowsCorrectReport
	
	portfolioo add: accountt.
	Deposit register: 100 * peso on: accountt.
	Withdraw register: 20 * peso on: accountt.
	Transfer from: accountt to: seconddaryAccount forAnAmountOf: 100 * peso.
	Transfer from: seconddaryAccount to: accountt forAnAmountOf: 50 * peso.
	reportToMatchh add: 'Neto de Transferencias = -50 pesos'.
	
	self assert: portfolioTransferNet report equals: reportToMatchh.! !


!classDefinition: #PortfolioPrinterTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioPrinterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!


!classDefinition: #PortfolioDetailedTreePrinterTest category: 'ServiciosFinancieros-Ejercicio'!
PortfolioPrinterTest subclass: #PortfolioDetailedTreePrinterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioDetailedTreePrinterTest methodsFor: 'as yet unclassified' stamp: 'fv 12/6/2021 18:12:18'!
test01EmptyPortfolioShowsEmptyTree

	| familyPortfolio arbol coincidencia |
	
	familyPortfolio := Portfolio named: 'Portfolio de la familia'.
	arbol := PortfolioDetailedTreePrinter of: familyPortfolio.
	coincidencia := OrderedCollection with: 'Portfolio de la familia'.
	
	self assert: coincidencia equals: arbol print.! !

!PortfolioDetailedTreePrinterTest methodsFor: 'as yet unclassified' stamp: 'fv 12/6/2021 18:27:07'!
test02PortfolioWithEmptyAccountShowsEmptyBalanceOnDetailedTree

	| familyPortfolio arbol coincidencia myAccount  |
	
	familyPortfolio := Portfolio named: 'Portfolio de la familia'.
	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	familyPortfolio  add: myAccount.
	arbol := PortfolioDetailedTreePrinter of: familyPortfolio.
	
	coincidencia := OrderedCollection with: 'Portfolio de la familia' with: '    Cuenta mia' with: '        Balance = 0 pesos'.
	
	self assert: coincidencia equals: arbol print.! !


!classDefinition: #PortfolioTreePrinterTest category: 'ServiciosFinancieros-Ejercicio'!
PortfolioPrinterTest subclass: #PortfolioTreePrinterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTreePrinterTest methodsFor: 'as yet unclassified' stamp: 'AT 12/6/2021 18:45:01'!
test01EmptyPortfolioOnlyShowsItself

	| familyPortfolio arbol coincidencia |
	
	familyPortfolio := Portfolio named: 'Portfolio de la familia'.
	arbol := PortfolioTreePrinter of: familyPortfolio.
	coincidencia := OrderedCollection with: 'Portfolio de la familia'.
	
	self assert: coincidencia equals: arbol print.! !

!PortfolioTreePrinterTest methodsFor: 'as yet unclassified' stamp: 'AT 12/6/2021 18:45:38'!
test02PortfolioWithAnAccountShowsCorrectTree

	| familyPortfolio arbol coincidencia myAccount  |
	
	familyPortfolio := Portfolio named: 'Portfolio de la familia'.
	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	familyPortfolio  add: myAccount.
	arbol := PortfolioTreePrinter of: familyPortfolio.
	
	coincidencia := OrderedCollection with: 'Portfolio de la familia' with: '    Cuenta mia'.
	
	self assert: coincidencia equals: arbol print.! !

!PortfolioTreePrinterTest methodsFor: 'as yet unclassified' stamp: 'AT 12/6/2021 18:46:05'!
test03PortfolioWithMultipleAccountsShowsCorrectTree

	| familyPortfolio arbol coincidencia myAccount florenciaAccount  |
	
	familyPortfolio := Portfolio named: 'Portfolio de la familia'.
	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	florenciaAccount := ReceptiveAccount named: 'Cuenta de Florencia'.
	familyPortfolio  add: myAccount.
	familyPortfolio add: florenciaAccount.
	arbol := PortfolioTreePrinter of: familyPortfolio.
	
	coincidencia := OrderedCollection with: 'Portfolio de la familia' with: '    Cuenta mia' with: '    Cuenta de Florencia'.
	
	self assert: coincidencia equals: arbol print.! !

!PortfolioTreePrinterTest methodsFor: 'as yet unclassified' stamp: 'AT 12/6/2021 18:46:43'!
test04PortfolioWithAEmptyPortfolioShowsCorrectTree

	| familyPortfolio arbol coincidencia childrenPortfolio|
	
	familyPortfolio := Portfolio named: 'Portfolio de la familia'.
	childrenPortfolio := Portfolio named: 'Portfolio de hijos'.
	familyPortfolio  add: childrenPortfolio.
	arbol := PortfolioTreePrinter of: familyPortfolio.
	
	coincidencia := OrderedCollection with: 'Portfolio de la familia' with: '    Portfolio de hijos'.
	
	self assert: coincidencia equals: arbol print.! !

!PortfolioTreePrinterTest methodsFor: 'as yet unclassified' stamp: 'AT 12/6/2021 18:47:18'!
test05PortfolioWithANonEmptyPortfolioShowsCorrectTree

	| familyPortfolio arbol coincidencia childrenPortfolio florenciaAccount|
	
	familyPortfolio := Portfolio named: 'Portfolio de la familia'.
	childrenPortfolio := Portfolio named: 'Portfolio de hijos'.
	florenciaAccount := ReceptiveAccount named: 'Cuenta de Florencia'.
	childrenPortfolio add: florenciaAccount.
	familyPortfolio  add: childrenPortfolio.
	arbol := PortfolioTreePrinter of: familyPortfolio.
	
	coincidencia := OrderedCollection with: 'Portfolio de la familia' with: '    Portfolio de hijos' with: '        Cuenta de Florencia'.
	
	self assert: coincidencia equals: arbol print.! !


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
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Account methodsFor: 'as yet unclassified' stamp: 'AT 12/5/2021 11:58:29'!
accept: aPortfolioTreePrint

	self subclassResponsibility ! !

!Account methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 15:45:20'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 15:46:00'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 16:04:57'!
includes: anAccount

	self subclassResponsibility ! !

!Account methodsFor: 'as yet unclassified' stamp: 'AT 12/5/2021 11:40:16'!
initializeWithName: anAccountName

	self initialize.
	name := anAccountName ! !

!Account methodsFor: 'as yet unclassified' stamp: 'AT 12/5/2021 11:29:44'!
name

	^name! !

!Account methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 15:46:28'!
transactions

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'ServiciosFinancieros-Ejercicio'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'as yet unclassified' stamp: 'AT 12/5/2021 11:39:04'!
named: aNameAccount
	
	^self new initializeWithName: aNameAccount.
	! !

!Account class methodsFor: 'as yet unclassified' stamp: 'AT 12/5/2021 10:58:39'!
named: aNameAccount with: anAccount
	
	self subclassResponsibility ! !

!Account class methodsFor: 'as yet unclassified' stamp: 'AT 12/5/2021 10:58:49'!
named: aNameAccount with: anAccount with: anotherAccount
	
	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'AT 12/5/2021 12:09:05'!
accept: aPortfolioTreePrint

	aPortfolioTreePrint visitPortfolio: self.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'AT 12/5/2021 11:52:55'!
accounts

	^accounts! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'fv 11/29/2021 17:14:29'!
add: anAccount
	
	self assertThatAccountIsNotDuplicate: anAccount .
	accounts add: anAccount 
! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'fv 11/29/2021 17:14:13'!
assertThatAccountIsNotDuplicate: anAccount

	((self isSameAccount: anAccount)or: [self includesTo: anAccount])ifTrue: [self error: Portfolio canNotAddSameAccountTwice].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'AT 12/3/2021 15:26:19'!
balance

	^accounts sum: [:anElement | anElement balance] ifEmpty:[0*peso].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 15:57:03'!
hasRegistered: aTransaction
	
	^accounts anySatisfy: [ :anElement | (anElement hasRegistered: aTransaction)].
	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 16:04:19'!
includes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 16:17:32'!
includesTo: anAccount

	^accounts anySatisfy: [:element | element includes: anAccount ]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 15:56:53'!
initialize

	accounts := OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 16:12:00'!
isSameAccount: anAccount

	^self = anAccount! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 15:56:45'!
numberAccounts

	^accounts size! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 15:56:48'!
transactions 
	| transactionsList |
	transactionsList := OrderedCollection new.
	
	accounts do:[:anElement | transactionsList addAll: (anElement transactions)].
	^transactionsList ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 09:56:18'!
canNotAddSameAccountTwice

	^'No se puede agregar una cuenta dos veces al mismo portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'AT 12/5/2021 11:11:11'!
named: aNameAccount with: anAccount
	
	^(self new initializeWithName: aNameAccount) add: anAccount .! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'AT 12/5/2021 11:11:27'!
named: aNameAccount with: anAccount with: anotherAccount
	
	^(self new initializeWithName: aNameAccount) add: anAccount; add: anotherAccount .
	! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'fv 12/3/2021 19:08:18'!
balance

	^transactions inject: (0 * peso) into: [ :partialResult :aTransaction |  aTransaction affectBalance: partialResult ].! !

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


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'AT 12/5/2021 12:09:10'!
accept: aPortfolioTreePrint

	aPortfolioTreePrint visitReceptiveAccount: self.! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 16:03:09'!
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


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'AT 12/6/2021 18:54:01'!
accept: anAccountSummary

	self subclassResponsibility.! !

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


!Deposit methodsFor: 'as yet unclassified' stamp: 'AT 12/4/2021 13:55:36'!
accept: anAccountSummary

	anAccountSummary visitDeposit: self value! !

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

!TransferLeg methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 16:06:29'!
initializeFor: aTransfer

	self subclassResponsibility ! !

!TransferLeg methodsFor: 'as yet unclassified' stamp: 'fv 12/2/2021 23:30:32'!
transfer

	^transfer! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Ejercicio'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferDepositLeg methodsFor: 'as yet unclassified' stamp: 'AT 12/4/2021 13:55:36'!
accept: anAccountSummary

	anAccountSummary visitTransferDepositLeg: self transfer value! !

!TransferDepositLeg methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 08:39:02'!
affectBalance: partialBalance
	
	^partialBalance + transfer value! !

!TransferDepositLeg methodsFor: 'as yet unclassified' stamp: 'AT 11/23/2021 09:32:39'!
counterPart

	^transfer withdraw .! !

!TransferDepositLeg methodsFor: 'as yet unclassified' stamp: 'fv 11/25/2021 19:33:03'!
initializeFor: aTransfer

	transfer := aTransfer ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDepositLeg class' category: 'ServiciosFinancieros-Ejercicio'!
TransferDepositLeg class
	instanceVariableNames: ''!

!TransferDepositLeg class methodsFor: 'as yet unclassified' stamp: 'fv 11/25/2021 19:30:34'!
for: aTransfer

	^ self new initializeFor: aTransfer ! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Ejercicio'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferWithdrawLeg methodsFor: 'as yet unclassified' stamp: 'AT 12/4/2021 13:55:36'!
accept: anAccountSummary

	anAccountSummary visitTransferWithdrawLeg: self transfer value! !

!TransferWithdrawLeg methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 08:50:13'!
affectBalance: partialBalance
	
	^partialBalance - transfer value! !

!TransferWithdrawLeg methodsFor: 'as yet unclassified' stamp: 'AT 11/23/2021 09:32:53'!
counterPart

	^transfer deposit.! !

!TransferWithdrawLeg methodsFor: 'as yet unclassified' stamp: 'fv 11/25/2021 19:33:08'!
initializeFor: aTransfer

	transfer := aTransfer ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdrawLeg class' category: 'ServiciosFinancieros-Ejercicio'!
TransferWithdrawLeg class
	instanceVariableNames: ''!

!TransferWithdrawLeg class methodsFor: 'as yet unclassified' stamp: 'fv 11/25/2021 19:30:45'!
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


!Withdraw methodsFor: 'as yet unclassified' stamp: 'AT 12/4/2021 13:55:36'!
accept: anAccountSummary

	anAccountSummary visitWithdraw: self value! !

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


!classDefinition: #BankReport category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #BankReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!BankReport methodsFor: 'main protocol' stamp: 'AT 12/6/2021 18:49:44'!
visitTransferDepositLeg: aTransactionValue
	
	self subclassResponsibility .
! !

!BankReport methodsFor: 'main protocol' stamp: 'AT 12/6/2021 18:49:56'!
visitTransferWithdrawLeg: aTransactionValue
	
	self subclassResponsibility .! !


!BankReport methodsFor: 'as yet unclassified' stamp: 'AT 12/6/2021 18:54:20'!
initializeWith: anAccount

	self subclassResponsibility .! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Ejercicio'!
BankReport subclass: #AccountSummary
	instanceVariableNames: 'account summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountSummary methodsFor: 'initialize' stamp: 'fv 12/4/2021 12:31:42'!
initializeWith: anAccount

	account := anAccount.
	summary := OrderedCollection new.! !


!AccountSummary methodsFor: 'main protocol' stamp: 'fv 12/5/2021 17:35:28'!
summary

	| accountTransactions |
	accountTransactions := account transactions.
	accountTransactions do: [ :aTransaction | aTransaction accept: self ].
	summary add: 'Balance = ', (account balance) asString.
	^summary! !


!AccountSummary methodsFor: 'double dispatch' stamp: 'AT 12/4/2021 13:51:21'!
visitDeposit: aTransactionValue
	
	summary add: 'Deposito por ', aTransactionValue asString! !

!AccountSummary methodsFor: 'double dispatch' stamp: 'AT 12/4/2021 13:52:22'!
visitTransferDepositLeg: aTransactionValue
	
	summary add: 'Entrada por transferencia de ', aTransactionValue asString.
! !

!AccountSummary methodsFor: 'double dispatch' stamp: 'AT 12/4/2021 13:52:10'!
visitTransferWithdrawLeg: aTransactionValue

	summary add: 'Salida por transferencia de ', aTransactionValue asString.! !

!AccountSummary methodsFor: 'double dispatch' stamp: 'AT 12/4/2021 13:51:43'!
visitWithdraw: aTransactionValue
	
	summary add: 'Extraccion por ', aTransactionValue asString.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'ServiciosFinancieros-Ejercicio'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'as yet unclassified' stamp: 'fv 12/2/2021 22:45:21'!
of: anAccount

	^self new initializeWith: anAccount! !


!classDefinition: #TransferNet category: 'ServiciosFinancieros-Ejercicio'!
BankReport subclass: #TransferNet
	instanceVariableNames: 'account report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferNet methodsFor: 'double dispatch' stamp: 'AT 12/4/2021 13:52:42'!
visitTransferDepositLeg: aTransactionValue
	
	report := report + aTransactionValue! !

!TransferNet methodsFor: 'double dispatch' stamp: 'AT 12/4/2021 13:52:52'!
visitTransferWithdrawLeg: aTransactionValue
	
	report := report - aTransactionValue! !


!TransferNet methodsFor: 'initialize' stamp: 'AT 12/3/2021 15:26:06'!
initializeWith: anAccount

	account := anAccount.
	report := (0*peso).! !


!TransferNet methodsFor: 'main protocol' stamp: 'AT 12/4/2021 13:53:59'!
report

	| accountTransactions |
	accountTransactions := account transactions.
	accountTransactions do: [ :aTransaction | 
		(aTransaction isKindOf: TransferLeg)
		ifTrue: [aTransaction accept: self ]].

	^OrderedCollection with: ('Neto de Transferencias = ', report asString)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'ServiciosFinancieros-Ejercicio'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'as yet unclassified' stamp: 'fv 12/3/2021 00:23:28'!
of: anAccount

	^self new initializeWith: anAccount! !


!classDefinition: #PortfolioPrinter category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #PortfolioPrinter
	instanceVariableNames: 'portfolio tree tab'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioPrinter methodsFor: 'as yet unclassified' stamp: 'AT 12/6/2021 18:42:02'!
initializeWith: aPortfolio

	portfolio := aPortfolio.
	tree := OrderedCollection new.
	tab := '    '.! !

!PortfolioPrinter methodsFor: 'as yet unclassified' stamp: 'AT 12/6/2021 18:48:23'!
print
	
	self subclassResponsibility .! !

!PortfolioPrinter methodsFor: 'as yet unclassified' stamp: 'AT 12/6/2021 18:48:33'!
visitPortfolio: aPortfolio

	self subclassResponsibility .! !

!PortfolioPrinter methodsFor: 'as yet unclassified' stamp: 'AT 12/6/2021 18:48:46'!
visitReceptiveAccount: aReceptiveAccount

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioPrinter class' category: 'ServiciosFinancieros-Ejercicio'!
PortfolioPrinter class
	instanceVariableNames: ''!

!PortfolioPrinter class methodsFor: 'as yet unclassified' stamp: 'AT 12/5/2021 11:24:47'!
of: aPortfolio

	^self new initializeWith: aPortfolio.! !


!classDefinition: #PortfolioDetailedTreePrinter category: 'ServiciosFinancieros-Ejercicio'!
PortfolioPrinter subclass: #PortfolioDetailedTreePrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioDetailedTreePrinter methodsFor: 'double dispatch' stamp: 'AT 12/6/2021 18:42:15'!
visitPortfolio: aPortfolio

	tree add: tab, aPortfolio name.
	aPortfolio accounts do: [ :anAccount | anAccount accept: self ].! !

!PortfolioDetailedTreePrinter methodsFor: 'double dispatch' stamp: 'AT 12/6/2021 18:42:41'!
visitReceptiveAccount: aReceptiveAccount

	| summary |
	summary := (AccountSummary of: aReceptiveAccount) summary.
	tree add: '    ', aReceptiveAccount name.
	tab := '        '.
	summary do: [ :line | tree add: tab, line ].
	tab := '    '.
	^tree! !


!PortfolioDetailedTreePrinter methodsFor: 'main protocol' stamp: 'fv 12/6/2021 18:03:40'!
print
	
	| accounts |
	
	tree add: portfolio name.

	accounts := portfolio accounts.
	
	accounts do: [ :anAccount | anAccount accept: self ].
	
	^tree! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros-Ejercicio'!
PortfolioPrinter subclass: #PortfolioTreePrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTreePrinter methodsFor: 'main protocol' stamp: 'AT 12/5/2021 11:55:25'!
print
	
	| accounts |
	
	tree add: portfolio name.

	accounts := portfolio accounts.
	
	accounts do: [ :anAccount | anAccount accept: self ].
	
	^tree! !


!PortfolioTreePrinter methodsFor: 'double dispatch' stamp: 'AT 12/6/2021 18:43:37'!
visitPortfolio: aPortfolio

	tree add: tab, aPortfolio name.
	tab := '        '.
	aPortfolio accounts do: [ :anAccount | anAccount accept: self ].
	tab := '    '.! !

!PortfolioTreePrinter methodsFor: 'double dispatch' stamp: 'AT 12/6/2021 18:43:09'!
visitReceptiveAccount: aReceptiveAccount

	^tree add: tab, aReceptiveAccount name.! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value deposit withdraw'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'nil' stamp: 'AT 11/21/2021 15:11:11'!
initializeWith: aValue aDeposit: aTransferDeposit aWithdraw: aTransferWithdraw.

	value := aValue.
	deposit := aTransferDeposit.
	withdraw := aTransferWithdraw .! !

!Transfer methodsFor: 'nil' stamp: 'AT 11/20/2021 21:49:13'!
value

	^value! !


!Transfer methodsFor: 'as yet unclassified' stamp: 'AT 11/21/2021 15:17:30'!
deposit

	^deposit! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'AT 11/21/2021 15:17:37'!
withdraw

	^withdraw! !

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


!Transfer class methodsFor: 'as yet unclassified' stamp: 'AT 11/23/2021 11:26:29'!
assertThatTransferAmountIsValid: aValue 
	
	(aValue <= 0) ifTrue: [self error: self transferCanNotBeNegativeOrZeroErrorDescription].! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 16:48:10'!
assertThatTransferIsValidBetween: anOriginAccount and: aDestinationAccount
	
	(anOriginAccount = aDestinationAccount) ifTrue:[^self error: self transferCanNotBeBetweenTheSameAccountErrorDescription].! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 16:48:59'!
transferCanNotBeBetweenTheSameAccountErrorDescription

	^'Transfer destination account must be different from origin account'.

	! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'AT 11/29/2021 16:49:06'!
transferCanNotBeNegativeOrZeroErrorDescription

	^'Transfer value must be positive'! !
