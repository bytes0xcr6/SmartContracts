# Alien Codex Challenge
![BigLevel19](https://user-images.githubusercontent.com/102038261/220411016-a732730a-1e20-4c14-a4ae-6d8c694c80bf.svg)

You've uncovered an Alien contract. Claim ownership to complete the level.

  Things that might help

- Understanding how array storage works
- Understanding ABI specifications
- Using a very underhanded approach

## To solve the challenge we need to...

- Until Solidity 0.5.0 we could under & overflow numbers (Even array index). If we underflow the array index we will get access to all previous storage slots from the contract.
- We should pay attention of how the Storage slots works in the EVM.
```
  MAX Storage per slot is: 32 bytes;
  
  // uint8 public a=7 // 1 byte
  // uint16 public b=12 // 2 bytes
  // address public c=0xasdkhfk...... // 20 bytes
  // bool d=true //1 byte
  // uint64 public e=12 //8 bytes
  // uint256 public f=213 // 32 bytes
  
  // Slot 0 = _owner (address = 20 bytes) + contact (bool 1 bytes) 
  // Slot 1 =  codex[]
```
1- Switch contact to true. (Modifier)

2- Underflow the array to go to the previous Storage slot. (Slot 0) (Where the _owner is stored)

3- After underflowing the array we need to get in which slot is the owner.

4- Modify the slot 0 (owner) with the caller address.
