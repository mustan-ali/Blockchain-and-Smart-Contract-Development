// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0

pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MyToken is ERC20 {
    constructor(address recipient) ERC20("MyToken", "MTK") {
        _mint(recipient, 1000000 * 1**decimals());
    }
}

contract ERC20Auction {
    struct Listing {
        address seller;
        IERC20 token;
        uint256 pricePerToken;
        uint256 remainingAmount;
    }

    MyToken public token;

    constructor(address _token) {
        token = MyToken(_token);
    }

    Listing[] listingArray;
    mapping(uint256 => uint256) public frontRunning;

    function ListToken(
        IERC20 _token,
        uint256 _totalAmount,
        uint256 _price
    ) public {
        token.transferFrom(msg.sender, address(this), _totalAmount);
        listingArray.push(Listing(msg.sender, _token, _price, _totalAmount));
    }

    function BuyToken(uint256 _listingId, uint256 _amount) public payable {
        require(_listingId < listingArray.length);
        require(_amount > 0, "Should be greater than ZERO");
        require(
            block.timestamp > frontRunning[_listingId] + 1 minutes,
            "Can't buy in this time"
        );
        require(
            listingArray[_listingId].remainingAmount >= _amount,
            "Insufficient Balance"
        );
        require(msg.value >= _amount * listingArray[_listingId].pricePerToken, "Value should be greater than amount X price");

        token.transferFrom(msg.sender, address(this), msg.value);
        frontRunning[_listingId] = block.timestamp;
    }

    function getListCount() public view returns (uint256) {
        return listingArray.length;
    }
}
