// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./ERC20.sol";

contract customERC20 is ERC20 {

    //constructor Smart Contract
    constructor() ERC20("Cristian", "CR6"){}

    // Creation of new tokens
    function createTokens() public{
        _mint(msg.sender, 1000);
    }
}
