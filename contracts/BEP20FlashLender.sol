// SPDX-License-Identifier: MIT
pragma solidity ^0.6.8;

import "../contracts/IBEP20FlashBorrower.sol";
import "../contracts/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";



// @notice Any contract that inherits this contract becomes a flash lender of any ERC20 tokens that it has whitelisted.
contract BEP20FlashLender is Ownable, ReentrancyGuard{
    using SafeMath for uint256;

    uint256 internal _tokenBorrowFee = 0.001e18; // e.g.: 0.003e18 means 0.3% fee (at 0.1%)
    uint256 constant internal ONE = 1e18;

    // only whitelist tokens whose `transferFrom` function returns false (or reverts) on failure
    mapping(address => bool) internal _whitelist;

    // @notice Borrow tokens via a flash loan
    function BEP20FlashLoan(address token, uint256 amount,string memory token1, string memory token2, string memory token3) external {
        // token must be whitelisted by Lender
        require(_whitelist[token], "token not whitelisted");

        // record debt
        uint256 debt = amount.mul(ONE.add(_tokenBorrowFee)).div(ONE);

        // send borrower the tokens
        require(IERC20(token).transfer(msg.sender, amount), "borrow failed");

        // hand over control to borrower
        IBEP20FlashBorrower(msg.sender).executeOnBEP20FlashLoan(token, amount, debt, token1, token2, token3);

        // repay the debt
        require(IERC20(token).transferFrom(msg.sender, address(this), debt), "repayment failed");
    }

    function tokenBorrowerFee() public view returns (uint256) {
        return _tokenBorrowFee;
    }
}