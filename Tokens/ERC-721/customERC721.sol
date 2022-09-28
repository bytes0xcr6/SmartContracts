// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

// OpenZeppelin
import "@openzeppelin/contracts@4.5.0/token/ERC721/ERC721.sol";
// Counter to add an ID to each NFT.
import "@openzeppelin/contracts@4.5.0/utils/Counters.sol";

contract erc721 is ERC721{

    // Counter for the NFT IDs
    using Counters for Counters.Counter;
    Counters.Counter private _tokensIds;

    //Constructor
    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol){}

    // NFTs transfers
    function sendNFT(address _account) public {
        _tokensIds.increment();
        uint256 newItemId = _tokensIds.current();
        _safeMint(_account, newItemId);
    }

}
