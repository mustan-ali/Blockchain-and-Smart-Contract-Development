// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MustanAli is ERC20 {

    constructor(address recipient) ERC20("MustanAli", "MA") {
        _mint(recipient, 100000 * 10**decimals());
    }
}

contract Staking {
    
    MustanAli public token;
    mapping (address => uint256) public stakedAmount;

    function stake(uint256 _amount) public {
        stakedAmount[msg.sender] += _amount;
        token.transfer(address(this), _amount);
    }

    function unstake(uint256 _amount) public {
        require(stakedAmount[msg.sender] <= _amount, "Insufficient staked amount");
        stakedAmount[msg.sender] -= _amount;
        token.transfer(msg.sender, _amount);
    }
}
        