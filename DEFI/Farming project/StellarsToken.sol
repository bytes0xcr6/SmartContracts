// SPDX-License-Identifier: MIT

//Smart contract for the Staking rewards. 
pragma solidity ^0.8.4;

contract StellarsToken{

    // Initial Declarations
    string public name = "Stellars Token";
    string public symbol = "STE";
    uint256 public totalSupply = 1000000000000000000000000; // 1 Million tokens (24 zeros, as it will have decimals)
    uint256 public decimals = 18;

    // Event for the token transfer 
    event Transfer(address indexed _from, address indexed _to, uint256 value);

    // Event for the operator approval
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    // Data structs
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    // Constructor
    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }

    // Token transfer
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    // Token transfer with Approval
    function transferFrom(address _from, address _to, uint256 _value) public returns(bool success){
        require(allowance[_from][msg.sender] >= _value);
        require (balanceOf[_from] >= _value);
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    // Approve spender
    function approveOrIncreaseAllowance(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] += _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // Remove Approval
    function removeApproval(address _spender, uint256 _value) public returns(bool success){
        allowance[msg.sender][_spender] -= _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }


}
