// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./Privacy.sol";

contract Attacker{

    Privacy privacy;

    constructor(Privacy _privacy) public{
        privacy = _privacy;
    }

    function attack(bytes32 _key) public {
        privacy.unlock(bytes16(_key));
    }

}
