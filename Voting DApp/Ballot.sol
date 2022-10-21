// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

// Voting contract.
// Users will be able to vote the proposal they prefer.

// Ability to:
// 1. Accept proposals and store them.
// 2. Vote for all the proposals.
// 4. Check that voters are authenticated to vote.

// Chairperson will be able to authenticate and deploy contract.

// Example in bytes32 (Node + Ethers):
// new_coffee_machine -->  0x6e65775f636f666665655f6d616368696e650000000000000000000000000000
// new_microwave -->  0x6e65775f6d6963726f7761766500000000000000000000000000000000000000

contract Ballot {

    struct Voter {
        uint weight; // How many times you can vote.
        bool voted; // Boolean to avoid double voting.
        uint proposalNumber; // Each proposal will have an ID.
    }

    // Proposal struct
    struct Proposal {
    bytes32 name; // Name of each proposal. Bytes is cheaper in gas than String.
    uint voteCount; // Number of accumulated votes
    }

    // Array to store all the proposals.
    Proposal[] public proposals;
    // Mapping to store all the Voter details.
    mapping(address => Voter) public voters;

    // Chaiperson => President. The person who can send proposals to be voted.
    address public chairperson;
    // Total voting time
    uint256 timeToVote; 


    constructor(bytes32[] memory  proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;
        timeToVote = uint256(block.timestamp + 1 days);

        for(uint i=0; i < proposalNames.length; i++){
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    // Authenticate votes
    function giveRightToVote(address _voter) public {
        require(msg.sender == chairperson, "Only the chairPerson can give access to vote");
        require(!voters[_voter].voted, "This Voter has already voted");
        require(voters[_voter].weight == 0);
        voters[_voter].weight = 1;
    }

    // Voting function
    function vote(uint _proposalNumber) public {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "Sender has no right to vote");
        require(!sender.voted, "Sender has already voted");
        require(timeToVote > block.timestamp,"Time is over");
        sender.voted = true;
        sender.proposalNumber = _proposalNumber;
        proposals[_proposalNumber].voteCount = proposals[_proposalNumber].voteCount + sender.weight;
        sender.weight = 0;
    }

    // function that shows the winner by name, only when the votation is finished.
    // It will loop all the proposals while it is storing the highest value, until the highest is stored
    // then, it will return the name of the proposal with more votes. (winnerProposal)
    function winnerProposal() public view returns(bytes32 winnerProposal) {
        require(timeToVote < block.timestamp,"Votes are still coming through");
        
        uint winningProposalCount = 0;
        for(uint i=0; i < proposals.length; i++) {
            if(proposals[i].voteCount > winningProposalCount){
               winningProposalCount = proposals[i].voteCount;
               winnerProposal = proposals[i].name;
            }
        }
    } 
}
