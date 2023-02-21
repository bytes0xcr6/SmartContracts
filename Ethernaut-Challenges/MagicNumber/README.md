# MagicNumber Challenge
![BigLevel18](https://user-images.githubusercontent.com/102038261/219109479-932cd776-8f76-4de0-a692-ff2ca7c150d2.svg)

### Instructions from Ethernaut

To solve this level, you only need to provide the Ethernaut with a Solver, a contract that responds to whatIsTheMeaningOfLife() with the right number.

Easy right? Well... there's a catch.

The solver's code needs to be really tiny. Really reaaaaaallly tiny. Like freakin' really really itty-bitty tiny: 10 opcodes at most.

Hint: Perhaps its time to leave the comfort of the Solidity compiler momentarily, and build this one by hand O_o. That's right: Raw EVM bytecode.

Good luck!

### To solve the challenge we need to...

Understand how OPCODES WORK, here there are some links:

<a href="https://www.rapidtables.com/convert/number/decimal-to-hex.html">Decimals to Hexadecimals</a>
<a href="https://ethereum.org/en/developers/docs/evm/opcodes/">OPCODES FOR THE EVM</a>
<a href="https://blog.openzeppelin.com/deconstructing-a-solidity-contract-part-i-introduction-832efd2d7737/">Deconstructing a Solidity contract</a>
```
// PUSH1 = 0X60
// MSTORE = 0X52
// RETURN = 0Xf3
// CODECOPY = 0x39

// ----- CREATION CODE / STORE RUN TIME CODE TO MEMORY (12 BYTES) ----
// PUSH1 0X600a ("s"IZE OF RUNTIME OPCODES = 10 Bytes = 0a) for COPYCODE
// PUSH1 0x600c ("p"OSITION OF THE MEMORY STACK (Actual position)) for COPYCODE
// PUSH1 0x6000 ("p"OSITION for the COPYCODE param (Destination)) for COPYCODE
// CODECOPY 0X39 (NEEDS 3 Arguments: Destination, Current Position, Size)
// PUSH1 0x600a ("s"IZE OF RUNTIME OPCODE (10Bytes = 0a) for RETURN
// PUSH1 0x6000 ("p"OSITION IN MEMORY) for RETURN
// RETURN 0Xf3 ( Return Value of Size "s" at position "p").

// Inicialization opcode: 0x600a600c600039600a60000f3 (12 bytes)

// ----- STORE PROCESS (5 BYTES) ----
// PUSH1 0X602a (v- VALUE 42 = 0x2a)
// PUSH1 0X6050 (p- POSITION ON THE MEMORY STACK to store (0x50))
// MSTORE 0X52 (STORE "V"alue (0x2a "32bytes") IN "P"osition (0x50)

// ---- RETURN PROCESS (5 BYTES) ---
// PUSH1 0x6020 (s- SIZE OF THE VALUE & POSITION = 0x20 (32bytes))
// PUSH1 0X6050 (p- POSITION OF THE VALUE)
// RETURN 0xf3 (RETURN THE "V"alue = 42, RETURN the "S"ize = 0x20(32bytes)

// Runtime opcode: 602a60505260206050f3 (10 bytes)


// Final Bytes: 600a600c600039600a60000f3602a60505260206050f3 

```

### Steps to solve it through the console: 

1. set the variable with the byte code for the inicialization + Runtime opcode

```
    const bytecode = 600a600c600039600a60000f3602a60505260206050f3; 
```
    
2. deploy the contract

``` 
    contract42 = await web3.eth.sendTransaction({from: player, data: bytecode}); 
```
  
3. After deploying the contract we can set the address Solver in the target contract

```
    await contract.setSolver(contract42.contractAddress);
```
