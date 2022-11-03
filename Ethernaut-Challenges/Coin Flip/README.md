# Coin Flip challenge

<h3>Instructions from Ethernaut:</h3>
<p>This is a coin flipping game where you need to build up your winning streak by guessing the outcome of a coin flip. To complete this level you'll need to use your psychic abilities to guess the correct outcome 10 times in a row.

 Things that might help: 
 
 * section "Beyond the console"</p>

<h3>To solve the challenge we need to...</h3> 
<p>Create a function in a secondary contract to call the `flip( )` function in the `CoinFlip.sol` contract, when we call this function we need to set a requirement to only call the function, if the `lastHash` and thew new `blockNumber` is not the same. Then we call this function until it has successed at least 10 times.</p>
  
