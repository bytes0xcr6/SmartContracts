# NaughtCoin Challenge 
![BigLevel15](https://user-images.githubusercontent.com/102038261/218554565-4a6f597d-f598-4762-99a6-74db755b2f91.svg)

NaughtCoin is an ERC20 token and you're already holding all of them. The catch is that you'll only be able to transfer them after a 10 year lockout period. Can you figure out how to get them out to another address so that you can transfer them freely? Complete this level by getting your token balance to 0.

Things that might help:
- The ERC20 Spec
- The OpenZeppelin codebase

## To solve the challenge we need to...

The function "Transfer()" does not allow us to make any transfer as it will require 10 years to transfer the tokens. We need to take into account that "Transfer ()" is no the only function in the ERC20 contract to make transfers. So we can use "TransferFrom()".

1. We need to approve ourself to manage the tokens with the function "approve()". As this is a requirement for using "TransferFrom()".
2. We just call the function "TransferFrom()" passing as a parameter "from" our address, "to" any other address & "amount" the INITIAL_SUPPLY.
