# Delegation Challenge

![BigLevel6](https://user-images.githubusercontent.com/102038261/199746676-6477942b-a80d-4a4c-9cd6-f7ce73491e5a.svg)

<h3> Instructions from Ethernaut</h3>

<p> The goal of this level is for you to claim ownership of the instance you are given.

Things that might help

* Look into Solidity's documentation on the delegatecall low level function, how it works, how it can be used to delegate operations to on-chain libraries, and what implications it has on execution scope.
* Fallback methods
* Method ids </p>

<h3>To solve the challenge we need to... </h3>

<p>Call the "Delegation" contract via the "Fall back function". But first, we need to set a variable "pwnFunction".

```const pwnFunction = web3.utils.sha3("pwn()")```

Then we send a transaction to interact with the "fallBack function" and adding as a parameter the data "pwnFunction( )" to call the "pwn( )" function in the Delegate contract. Then it will set us as the Owner. 
</p>
