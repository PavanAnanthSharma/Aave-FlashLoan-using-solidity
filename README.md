# FlashLoan using Aave lendng pool        
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
```
@Dev/Author: Pavan Ananth Sharma      
``` 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

>What is a Flashloan? 

Flash loan attacks refer to a smart contract exploit where an attacker takes out a flash loan from a DeFi protocol, uses the capital that they've borrowed, and pays it back in the same transaction.
  
 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

>Why Flashloans? 

Some traders have successfully employed flash loans to speculate on new coins, without having to risk their own funds. And, because flash loans bundle several smart contract transactions into one, they can reduce transaction fees (which can add up to quite a bit).

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


>Flashloan starts here: 

This contains all the code to execute a successful flashloan on the Kovan test-net of Ethereum. Flashloan will be taken from the aave lending pool where will will take 1 DAI as a flashloan. Please do note that all the names of the files should not be changed and make sure you have got the Kovan test ethere, do not worry if you do not have, will be providing a link down and showing you  how to perform flashloan step by step.

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>Please follow along:
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

> Step1:   
Remix Setup 

For the sake of simplicity, we will be using the Remix IDE (remix.ethereum.org).
This is a browser-based IDE. Also known as an Integrated Development Environment.
Remix comes with the ability to write, debug, deploy, and otherwise manipulate Ethereum Smart Contracts.
We won’t be doing a deep dive on the IDE, as the focus of this tutorial is on the Flash Loan. However, you will want to become familiar with the four sections highlighted: main panel, side panel, icon panel, and terminal.

Before we start writing our smart contracts we will want to download a browser extension that allows us to interface with the Ethereum blockchain. There are several tools out there that unlock such functionality, but the most popular one is MetaMask.

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

>Step2:
MetaMask Setup  
A step-by-step breakdown of how to install MetaMask.

1.You will start by downloading the extension off of the chrome extension store.
2.Click on your newly installed extension and agree to the terms and conditions.
3.Create a secure password!
4.Write down the mnemonic seed phrase. This should be in the physical world, and shouldn’t be kept anywhere on your computer.
If the four steps outlined above are completed you are all ready to start writing your first smart contracts!

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

```
⚠️NOTE: FROM HERE STUFF GETS REALLY CRAZY AND TOUGH:⚠️

```  
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

> Step3: ```[VERY IMPORTANT]```

NOTE: Smart contracts allow us to read and write data to the blockchain by executing deterministic programs. When coding a smart contract for use on Ethereum, we use a programming language called Solidity. Solidity files end in the .sol extension.
PLEASE CREATE MULTIPLE ```.sol``` FILES AND MAKE SURE THEY HAVE THE SAME NAME AS PROVIDED BELOW:
1. FlashLoan.sol
2. FlashLoanReceiverBase.sol
3. ILendingPoolAddressesProvider.sol
4. IFlashLoanReceiver.sol
5. ILendingPool.sol
6. Withdrawable.sol 

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

>ALL THE CODES WILL BE GIVEN IN THE CONTRACTS FILES.

To summarize, we start by importing the dependencies required to execute our Flash Loan. Some of these dependencies are called abstract contracts. An abstract contract has at least one function that isn’t implemented. You can think of it as a blueprint of a house. A builder uses this blueprint to make a house. However, in our analogy the blueprint is an abstract contract, you are the builder, and the house is the derived contract.

In our case the Flash Loan contract is using an abstract contract called FlashLoanReceiverBaseV1. It provides necessary implementation details such as repayment of the Flash Loan.

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

> Now to break down the code line by line.
 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
1. First, we have to define the solidity compiler version. In this case, it's ^0.6.0.
     2-4. Importing dependencies for the smart contract
      6. The FlashLoanV1 contract is inheriting from the FlashLoanReceiverBaseV1 contract.
      8. We passed the address of one of the Lending Pool Providers of Aave. In this case, we are providing the address of DAI Lending Pool. 
     13. We have defined a function called flashLoan. It takes the address of the asset we want to flash loan. In this case the asset is DAI.
14. We don't have any need of data for the flash loan, so we are passing an empty string.
15. We are defining the number of DAI(in terms of wei which is 10^18) we want to loan.
16. We initialize the LendingPool interface which is ILendingPoolV1 provided by Aave so that we can call the flashLoan function.
17. Finally, we call our flashLoan function. The function takes 4 main parameters. First we pass the address which will receive the loan. In our case, it's our own contract. Second, we pass the address of the asset. In our case, it's the address of DAI in the Kovan network. Third, we pass the amount of assets, and in our case it's 1 “ether” amount of units(or 10^18 in “wei” units). Last but not least, we pass the data value which in our case is an empty string.
24-31 Next, we define the second function which is executeOperation. It’s where we utilize the flash loan. It’s called internally after the flashLoan function is successfully executed. It takes 4 main parameter which are -
        1. The address of reserve to which we will have to pay back the loan.
        2. The amount of asset
        3. The fee that is charged by the protocol
        4. Additional parameter which is used internally by the function.
33. It checks if we received the appropriate amount of loan or else it will throw an error message.
34. At this point, this is where you would implement logic for any arbitrary use case.
40. We add the fee along with the loan amount by using add function provided by SafeMaths library.
41.At last we pay back the total debt or loan amount back to the lending pool.

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

>Step4: Deploying The Contract
 
First, open your MetaMask and set your network to "Kovan Test Network".
Make sure you have kovan test ether to run the following transcation, please note this is Kovan test ether is to pay the gas fees for the flashloan.
Get kovan test here if you do not have any test ether
```[NOTE: DO NOT OVERLOAD YOUR WALLET WITH TEST ETHER PLEASE]```
```KOVAN TEST ETHER LINK: https://faucets.chain.link/kovan```
     ``` 1. Enter your account addrss.
      2. Select 0.1 test ETH and then check the confirmations.
      3. Wait for a few seconds and test ETH will be sent to the address what you had put.```
      
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

>Use this gist for defining the dependencies for flashloan smart contracts:
>ALL THE CONTRACTS WILL BE PROVIDED IN THE CONTRACTS FOLDER.

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

>Step5: 

Switch to the "Solidity Compiler" tab. Set the compiler to 0.6.6 and click on "Compile FlashLoan.sol".
If you have followed all the steps you should see some warnings but no error message.
Now, we are all set to deploy the contract to the Kovan network. Switch to "Deploy & Run Transactions" tab. Under the environment field, change it from JavaScript VM to Injected Web3. This should open MetaMask asking for your permission.
Make sure the “CONTRACT” field is set to FlashLoan.sol. Provide the address of LendingPool in the text field that is next to the deploy button. In our case, it will be ```0x506B0B2CF20FAA8f38a4E2B524EE43e1f4458Cc5.``` Then click “Deploy”. It should open up MetaMask.
```Address of lending pool = 0x506B0B2CF20FAA8f38a4E2B524EE43e1f4458Cc5```

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

>⚠️If you want other lending pools feel free to check them here: https://www.quicknode.com/guides/defi/how-to-make-a-flash-loan-using-aave⚠️.

>Click on “Confirm”. Upon doing so, you should see a success notification from MetaMask. There should now be a “Deployed Contracts” in the side panel.

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


>Step6: Funding The Flash Loan

Under the new “Deployed Contracts” tab, you will be able to copy the deployed contract's address. We will come back to this step later; in the meantime we need to add some DAI to our Flash Loan contract. This is because Flash Loans need funds in the contract to successfully execute.
```⚠️For that, you can jump to this link to get some DAI tokens: https://testnet.aave.com/faucet/DAI ⚠️.```
Be sure to connect to the “Aave v2 Market” with a little “K” in the top right corner. Click on the faucet, paste in your MetaMask wallet address, and wait for confirmation.
After obtaining confirmation, we are going to add the DAI token to MetaMask. For that, open your MetaMask. Click on “Add Token” at the bottom. In the “Token Contract Address” field enter ```0xFf795577d9AC8bD7D90Ee22b6C1703490b6512FD```. This is the contract address for DAI in Kovan. After clicking “Next”, It should display the DAI you got from the faucet earlier.
```DAI Token Contract Address = 0xFf795577d9AC8bD7D90Ee22b6C1703490b6512FD```

Next up, click on the DAI token. Click on “Send” and it should open a window
Enter our Flash Loan’s contract address, which we found out where to obtain earlier. Enter the amount which we want to send. In our case, we will send 10 DAI. Then click on "Next". Click on "Confirm"! You have now successfully given your Flash Loan contract 10 DAI.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>⚠️ If you dont know how to find the contract address, go to: https://kovan.etherscan.io/  and search your txn hash there you can find your contract address⚠️.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

>Step7: Executing The Flash Loan

Head back to Remix. Under the deployed Flash Loan contract, there’s another “flashloan” text field. This field takes a contract address of the asset we want to use. In our case it’s the Kovan Testnet’s DAI contract, which is ```0xFf795577d9AC8bD7D90Ee22b6C1703490b6512FD```. With that field correctly filled in, you can now hit the “transact” button below.
Upon clicking the button, MetaMask should pop up asking for approval of the transaction. Confirm the transaction and you should be greeted by a success message. In Remix’s terminal you should see all the transcation details, and there you will be able to find this transcation(txn)hash then copy the it again go to: https://kovan.etherscan.io/ and then paste the txn hash in the search bar.
```⚠️Under “Tokens Transferred”, you should see three different transactions.⚠️```
1. The first transaction highlights the transfer of 1 DAI from LendingPool to our contract.
2. The second transaction indicates the payback of 1 DAI along with the fees back to the lending pool.
3. The third transaction shows interest generated DAI which has its separate utility.

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> CONCLUSION
We were successfully able to write the smart contract for a Flash Loan! We were able to borrow DAI from the pool, pay the Flash Loan fee, and then repay the borrowed amount all in a single transaction. You just borrowed money with no collateral!
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

```If you enjoyed this full tutorial do consider following me on github as well as on my instagram!!```

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

> 0x592eF244F8924be9F3F8803f8d639392f465Ac51

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

 



 





