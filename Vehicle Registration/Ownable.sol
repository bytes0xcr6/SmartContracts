// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.4;

contract Ownable{
    address owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner{
        require(owner == msg.sender, "You are not the owner");
        _;
    }
}
