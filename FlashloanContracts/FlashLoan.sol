//Use the lisence here:  
pragma solidity ^0.6.6;
import "./FlashLoanReceiverBase.sol";
import "./ILendingPoolAddressesProvider.sol";
import "./ILendingPool.sol";

contract FlashloanV1 is FlashLoanReceiverBaseV1 {

    constructor(address _addressProvider) FlashLoanReceiverBaseV1(_addressProvider) public{}

 /**
        Flash loan 1000000000000000000 wei (1 ether) worth of `_asset`
     */
 function flashloan(address _asset) public onlyOwner {
        bytes memory data = "";
        uint amount = 10000 ether;

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
