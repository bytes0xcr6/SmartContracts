# Token Challenge

![BigLevel5](https://user-images.githubusercontent.com/102038261/199727904-a711cd8a-b89b-4a2f-9c45-21bd5c36276a.svg)

<h3>Instructions from Ethernaut</h3>

<p>The goal of this level is for you to hack the basic token contract below.

You are given 20 tokens to start with and you will beat the level if you somehow manage to get your hands on any additional tokens. Preferably a very large amount of tokens.

Things that might help:

* What is an odometer?</p>

<h3>To solve the challenge we need to...</h3> 
<p> As this contract is not using SafeMath and the Solidity version is before than v0.8.0 (when SafeMath was added to newer versions). 
  
It should have added the next line of code to the function "transfer( )" to avoid this problem:  </p>
```    require(balances[msg.sender] >= _value, "You are exceeding your balance of tokens") ```
