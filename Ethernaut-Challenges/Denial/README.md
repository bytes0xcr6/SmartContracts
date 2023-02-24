# Denial challenge
![BigLevel20](https://user-images.githubusercontent.com/102038261/221166808-b8e2878b-eee0-4c48-9e6d-a11fd9b0de14.svg)

## Instructions from Ethernaut:
This is a simple wallet that drips funds over time. You can withdraw the funds slowly by becoming a withdrawing partner.

If you can deny the owner from withdrawing funds when they call withdraw() (whilst the contract still has funds, and the transaction is of 1M gas or less) you will win this level.

## Vulnerabilities
- Anyone can become a partner, as the function is public and doesn´t have any requirement.
- By calling the function withdraw() it will do a low call to the partner address (Which in this case will be a contract address). This contract address can contain a fallback function with malicious logic.
- Funds could be dreaned easily.

## To solve it we need to...
1. Become a partner by calling the function setWithdrawPartner() by a contract;
2. Set the fallback function with the logic to run it until the gas is finished, so it won´t go till the next line of the withdrawn() function and the owner will never receive funds. (Of course, until another address becomes the partnet)
- To require that the gas is finished and not refunded, we need to use "assert()". Check image below:
<img width="538" alt="image" src="https://user-images.githubusercontent.com/102038261/221175597-923e6f06-f0c6-4286-a4d4-36e6ea972bd4.png">
