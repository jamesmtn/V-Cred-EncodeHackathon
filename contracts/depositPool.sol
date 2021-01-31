// SPDX-License-Identifier: MIT
pragma solidity ^0.6.8;
import "../contracts/BEP20FlashLender.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";


// ERC20 Flashloan Example
contract depositPool is BEP20FlashLender{
    // set the Lender contract address to a trusted flashmodule contract
	uint256 public totalfees; // total fees collected till now
    mapping(address => uint256) public balances;

    constructor() public {
        _whitelist[0x6ce8dA28E2f864420840cF74474eFf5fD80E65B8] = true; // BTCB
        _whitelist[0xd66c6B4F0be8CE5b39D52E0Fd1344c389929B378] = true; // ETHB
        _whitelist[0xEC5dCb5Dbf4B114C9d0F65BcCAb49EC54F6A0867] = true; // DAIB
    }
    
function deposit(
    address token,
    address onbehalfOf,
    uint256 amount
  )  public {
    require(_whitelist[token], "token not whitelisted");
    IERC20(token).transferFrom(onbehalfOf, address(this), amount);
  
  }
	

function withdraw(
    address token,
    address onbehalfOf
  ) public {
        require(_whitelist[token], "token not whitelisted");
        IERC20(token).transfer(onbehalfOf, IERC20(token).balanceOf(address(this)));
  }
}
