// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Pokemon Collection

import "@openzeppelin/contracts@4.5.0/token/ERC1155/ERC1155.sol";

contract erc1155 is ERC1155 {

    // Variables (IDs)
    uint256 public constant PIKACHU = 0;
    uint256 public constant CHARMANDER = 1;
    uint256 public constant BULBASUR = 2;
    uint256 public constant SQUIRTEL = 3;
    uint256 public constant ASH_KETCHUM = 4;


    // Constructor Smart Contract
    constructor() ERC1155("https://game.example/api/item/{id}.json"){
        _mint(msg.sender, PIKACHU, 1, "");
        _mint(msg.sender, CHARMANDER, 1*10**5, "");
        _mint(msg.sender, BULBASUR, 1*10**4, "");
        _mint(msg.sender, SQUIRTEL, 1*10**4, "");
        _mint(msg.sender, ASH_KETCHUM, 1, "");
    }
}
