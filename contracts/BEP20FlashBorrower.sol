// SPDX-License-Identifier: MIT
pragma solidity ^0.6.8;
pragma experimental ABIEncoderV2;

import "./BEP20FlashLender.sol";
import "./priceOracle.sol";
import "../contracts/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


// @notice Used by borrower to flash-borrow ERC20 tokens from ERC20FlashLender
// @dev Example contract. Do not use. Has not been audited.
contract BEP20FlashBorrower is Ownable {
    using SafeMath for uint256;
    uint256 arbVal;
    //set the oracle address to the deployed Band oracle contract address
    priceOracle public constant BAND_ORACLE = priceOracle(address(0x491118B72ef35046c387ec240EBad4807f943932));
    // set the Lender contract address to a trusted ERC20FlashLender
    BEP20FlashLender public constant bep20FlashLender = BEP20FlashLender(address(0xCCcd586C777BA2817F75e04c4e7305cc77C710F9));
    uint256 constant internal ONE = 1e18;

    
    // @notice Borrow any ERC20 token that the ERC20FlashLender holds
    function borrow(address token, uint256 amount,string memory token1, string memory token2, string memory token3) public onlyOwner {    
       bep20FlashLender.BEP20FlashLoan(token, amount, token1, token2, token3);
    }


    // this is called by ERC20FlashLender after borrower has received the tokens
    // every ERC20FlashBorrower must implement an `executeOnERC20FlashLoan()` function.
    function executeOnBEP20FlashLoan(address token, uint256 amount, uint256 debt,string memory token1, string memory token2, string memory token3) external {
        require(msg.sender == address(bep20FlashLender), "only lender contract can execute");

        //... do whatever you want with the tokens to generate profit
        //assuming BTC as the entry point *BAND_ORACLE.getPrice("ETH","SXP")*BAND_ORACLE.getPrice("SXP","BTC")
     
        arbVal = BAND_ORACLE.getPrice(token1,token2).div(ONE).mul(BAND_ORACLE.getPrice(token2,token3).div(ONE)).mul(BAND_ORACLE.getPrice(token3,token1).div(ONE));
       
        //since we are on a testnet with no liquidity the liquidity from lender is used for test purposes
        //frontend will show a demo of the arbitrage value
        
        
        // authorize loan repayment
        IERC20(token).approve(address(bep20FlashLender), debt);
    }
}
