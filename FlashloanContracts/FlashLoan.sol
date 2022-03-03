//Use the lisence here: MIT & Apachai standart
//@dev/Developer = Pavan Ananth Sharma
//@.NET/Network = Kovan Test Network
pragma solidity ^0.6.6;
import "./FlashLoanReceiverBase.sol";
import "./ILendingPoolAddressesProvider.sol";
import "./ILendingPool.sol";

contract FlashloanV1 is FlashLoanReceiverBaseV1 {
    
    string _Real_Owner = "Pavan Ananth Sharma" ;
    
    function Owner_Of_This_Contract() public view returns(string memory){
        return _Real_Owner;
    }

    constructor(address _addressProvider) FlashLoanReceiverBaseV1(_addressProvider) public{}

 /**
        Flash loan 1000000000000000000 wei (1 ether) worth of `_asset`
     */
 function flashloan(address _asset) public onlyOwner {
        bytes memory data = "";
        uint amount = 1000000 ether; //this is the loan amount which will be seen or converted to DAI which means if you enter in 100 here you will be taking a loan of 100 DAI and so on.
        //basically we can say that this ebtered amount is converted to wei which is a small decimal of ETH and then it is placed in to the mem pool for the mining of the DAI 

        ILendingPoolV1 lendingPool = ILendingPoolV1(addressesProvider.getLendingPool());
        lendingPool.flashLoan(address(this), _asset, amount, data);
    }

    /**
  This function is called after your contract has received the flash loaned amount
     */
    function executeOperation(
        address _reserve,
        uint256 _amount,
        uint256 _fee,
        bytes calldata _params
    )
        external
        override
    {
        require(_amount <= getBalanceInternal(address(this), _reserve), "Invalid balance, was the flashLoan successful?");
       //
        // Your logic goes here.
        // !! Ensure that *this contract* has enough of `_reserve` funds to payback the `_fee` !!
        //

        uint totalDebt = _amount.add(_fee);
        transferFundsBackToPoolInternal(_reserve, totalDebt);
    }

}
//lending pool ID: 0x506B0B2CF20FAA8f38a4E2B524EE43e1f4458Cc5
// DAI ID:  0xFf795577d9AC8bD7D90Ee22b6C1703490b6512FD

// 10 Million dollar worth flashloan txn hash: 0x13863519283a2b7405f59e3717b6e691387e663f1314419912a3116edc2eb237
// 100 Million dollar worth flashloan txn hash:  0x88ff14b895036663695deadd3694ee31e7cf634edd403f7ee11131a958aeb386
// 1 Billion dollar  worth flashloan : COMING UP SOON!!
