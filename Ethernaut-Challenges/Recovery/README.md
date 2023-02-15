# Recovery
![BigLevel17](https://user-images.githubusercontent.com/102038261/219020731-b12041e0-b86c-4296-9a9b-b33b6aafca17.svg)

A contract creator has built a very simple token factory contract. Anyone can create new tokens with ease. After deploying the first token contract, the creator sent 0.001 ether to obtain more tokens. They have since lost the contract address.

This level will be completed if you can recover (or remove) the 0.001 ether from the lost contract address.

# To solve this challenge we need to..

1- Check in EtherScan (Or any other blockchain Scan) the contract fabric. Once we find it we will see the contract address created from the fabric (Recovery.sol).

2- We just need to call the function "destroy()" that includes a "self-destruct()", we need to pass a contract address with a "receive()" function where we would like to receive the Matics/Ethers. Once we call it the contract will be destroyed and the funds will be transferred to the contract address passed as a parameter.
