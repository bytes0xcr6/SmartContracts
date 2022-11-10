# Gatekeeper One

![BigLevel13](https://user-images.githubusercontent.com/102038261/201179929-6383b9a1-1b69-4c74-a901-b6713e6a166f.svg)

<h3> Instructions from Ethernaut</h3>

Make it past the gatekeeper and register as an entrant to pass this level.

Things that might help:
* Remember what you've learned from the Telephone and Token levels.
* You can learn more about the special function gasleft(), in Solidity's documentation.

<h3>To solve the challenge we need to... </h3>


<strong>modifier gateOne( )</strong> -> We pass it by calling the contract via another contract, then the msg.sender will be the contract and the tx.origin our own address.
 
<strong>modifier gateTwo( )</strong> -> We use Brute force. We loop through the gas options until we hit a number that is modulo 8191. We mitigate the possibilities giving a big range.

<strong>modifier gateThree( )</strong> -> Explanation of the mask. When I'm enumerating bytes and hexadecimal numbers (be aware of the difference!) I start the count from the right most value.
* For condition 1: Needs bytes 3 and 4 to be 0 ((i.e. hexadecimal numbers 5 - 8  need to be 0, counted from the right)), as they will be truncated on the right side and the comparison still has to hold
* For condition 2: We need a non-zero-value anywhere in the the bytes 5-8 (e.g. hexanumbers 9-16), as the 64 bit cast has to differ from the 32 bit cast (the 32 bit cast zeroes out hexanumbers 9-16)
* For condition 3: last 2 bytes (i.e. last 4 hexanumbers) of origin-address required by condition 3.

I would recommend the next to articles to understand how to solve it:
* <a href="https://en.wikipedia.org/wiki/Mask_(computing)">Mask computing</a> 
* <a href="https://jeancvllr.medium.com/solidity-tutorial-all-about-bytes-9d88fdb22676">Solidity tutorial: all about bytes</a>
* <a href="https://blog.openzeppelin.com/deconstructing-a-solidity-contract-part-i-introduction-832efd2d7737/">Deconstructing a Solidity Contract</a>
* <a href="https://docs.soliditylang.org/en/v0.8.3/units-and-global-variables.html">gasleft( ) returns (uint256): remaining gas
</a>
