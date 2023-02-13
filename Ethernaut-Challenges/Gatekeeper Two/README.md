# GateKeeper Two
![BigLevel14 (1)](https://user-images.githubusercontent.com/102038261/218551870-3b321953-f33a-4f11-9b6d-dfa0ae466f87.svg)


This gatekeeper introduces a few new challenges. Register as an entrant to pass this level.

Things that might help:
- Remember what you've learned from getting past the first gatekeeper - the first gate is the same.
- The assembly keyword in the second gate allows a contract to access functionality that is not native to vanilla Solidity. See here for more information. The extcodesize call in this gate will get the size of a contract's code at a given address - you can learn more about how and when this is set in section 7 of the yellow paper.
- The ^ character in the third gate is a bitwise operation (XOR), and is used here to apply another common bitwise operation (see here). The Coin Flip level is also a good place to start when approaching this challenge.

# To solve this challenge we need to..

1. We pass the first gate by calling from a contract & not an EOA. ```msg.sender != tx.origin```
2. We pass the second gate by attacking from a contract that has 0 size code. (extcodesize) So we attack from the constructor.
```
    uint x;
    assembly { x := extcodesize(caller()) }
    require(x == 0); 
```
    
3. We pass the third gate by destructuring the require and using it to get the "key".

```
        uint64 a = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        uint64 b = type(uint64).max;
        bytes8 c = bytes8(a ^ b);
```
