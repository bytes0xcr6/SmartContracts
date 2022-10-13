// SPDX-License-Identifier: MIT

// DEFI Smart Contract for Staking.
pragma solidity ^0.8.4;

import "./JamToken.sol"; // Token to Stake.
import "./StellarsToken.sol"; // Token as reward.


contract TokenFarm {

    // Initial Declarations
    string public name = "Stellars Token Farm";
    address public owner;
    JamToken public jamToken; // Como importar el contrato sin que haya conflicto
    StellarsToken public stellarsToken;

    // Data structs
    address [] public stakers;
    mapping(address => uint256) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    // Constructor
    constructor(JamToken _jamToken, StellarsToken _stellarsToken) {
        jamToken = _jamToken;
        stellarsToken = _stellarsToken;
        owner = msg.sender;
    }

    // Stake Tokens
    function stakeTokens(uint256 _amount) public returns (bool success) {
        require(_amount > 0, "The amount needs to be greater than 0");
        // Transfer tokens from JAM to the main Smart Contract
        jamToken.transferFrom(msg.sender, address(this), _amount);
        stakingBalance[msg.sender] += _amount;
        
        if(!hasStaked[msg.sender]) {
        stakers.push(msg.sender);
        }

        hasStaked[msg.sender] = true;
        isStaking[msg.sender] = true;
        return true;
    }

    // Unstake Tokens (Customizable amount)
    function unstakeTokens(uint256 _amount) public {
        uint balance = stakingBalance[msg.sender];

        require(_amount > 0, "The amount needs to be greater than 0");
        require(balance >= _amount, "The balance staking needs to be greater than 0");
        balance -= _amount;
        jamToken.transferFrom(address(this), msg.sender, _amount);
        if(balance == 0) {
            hasStaked[msg.sender] = false;
            isStaking[msg.sender] = false;
        }
    }

    // Issue stellars Tokens (rewards) for Staking.
    function issueTokens() public {
        require(msg.sender == owner, "You need to be the owner");
        // Emit the reward to all the stakers
        for(uint256 i = 0; i < stakers.length; i++) {
            address recipient = stakers[i];
            uint balance = stakingBalance[recipient];
            if(balance > 0){
                stellarsToken.transfer(recipient, balance);
            }
        }
    }


}
