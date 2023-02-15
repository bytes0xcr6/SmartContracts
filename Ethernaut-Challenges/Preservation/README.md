# Preservation
<img width="395" alt="Captura de pantalla 2023-02-15 103342" src="https://user-images.githubusercontent.com/102038261/218989866-14dc0957-e964-4331-b7c5-c20e649a6fdb.png">

This contract utilizes a library to store two different times for two different timezones. The constructor creates two instances of the library for each time to be stored.

The goal of this level is for you to claim ownership of the instance you are given.

Things that might help:

- Look into Solidity's documentation on the delegatecall low level function, how it works, how it can be used to delegate operations to on-chain. libraries, and what implications it has on execution scope.
- Understanding what it means for delegatecall to be context-preserving.
- Understanding how storage variables are stored and accessed.
- Understanding how casting works between different data types.

### To solve the challenge we need to...
