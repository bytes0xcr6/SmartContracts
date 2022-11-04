# Re-entrancy Challenge

![BigLevel10](https://user-images.githubusercontent.com/102038261/199991492-e1b420e7-1233-443f-ae23-3774ca09c26b.svg)

<h3> Instructions from Ethernaut</h3>

The goal of this level is for you to steal all the funds from the contract.

Things that might help:

* Untrusted contracts can execute code where you least expect it.
* Fallback methods
* Throw/revert bubbling
* Sometimes the best way to attack a contract is with another contract.
* See the Help page above, section "Beyond the console"

<h3>To solve the challenge we need to... </h3>

<p>We need to create an Attacker contract to attack the "Reentrance" contract, It will donate value at the same time that it triggers the "Withdrawn" function. As it has a "fallback" function set to ask again for withdrawn meanwhile the first withdraw function has not set our balance to0. It will keep dreaning all the funds in the "Reentrance" contract.

To solve this problem, in the "Reentrance" contract we should set the balance before we transfer the funds.</p>
