// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

// On this second contract we will store all the Ballot contracts to keep a record.
// The only person with rights to store Ballots will be the chairPerson.

contract BallotStorage {

    uint public contractsCount;
    address public chairPerson;

    mapping(address => uint) public votingContracts;
    mapping(address => bool) public registered;

    constructor(){
        chairPerson = msg.sender;
    }

    function storeVotingContract(address _votingContract) external{
        require(chairPerson == msg.sender);
        require(!registered[_votingContract]);

        votingContracts[_votingContract] = contractsCount;
        contractsCount++;
    }
}
