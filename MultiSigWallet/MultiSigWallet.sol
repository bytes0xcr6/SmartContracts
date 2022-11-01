// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract MultiSigWallet {
    event Deposit(address indexed sender, uint amount, uint balance);
    event SubmitTransaction(uint indexed txId);
    event ApproveTransaction(address indexed owner, uint indexed txId);
    event RevokeTransaction(address indexed owner, uint indexed txId);
    event ExecuteTransaction(uint indexed txId);

    struct Transaction {
        address payable to;
        uint amount;
        bytes data;
        bool executed;
        uint numConfirmations;
    }

    Transaction[] public transactions;

    address[] owners;
    mapping(address => bool) isOwner;

    // mapping from tx index => owner => bool
    mapping(uint => mapping(address => bool)) approved;
    mapping(uint => bool) executed;
    uint confirmationsRequired;

    modifier onlyOwner() {
        require(isOwner[msg.sender], "You are not an owner");
        _;
    }

    modifier txNotApproved(uint _txId) {
        require(
            !approved[_txId][msg.sender],
            "The transaction is already approved"
        );
        _;
    }

    modifier txNotExecuted(uint _txId) {
        require(
            !transactions[_txId].executed,
            "The transaction has been already executed"
        );
        _;
    }

    modifier txExists(uint _txId) {
        require(
            transactions.length >= _txId,
            "The transaction does not exists"
        );
        _;
    }

    constructor(address[] memory _owners, uint _confirmationsRequired) {
        require(_owners.length > 0, "Owners needs to be greater than 0");
        require(
            _confirmationsRequired > 0 && _confirmationsRequired <= _owners.length,
            "Owners required needs to be greater than 0 & less than the total number of owners"
        );
        for (uint i = 0; _owners.length > i; i++) {
            address _owner = _owners[i];
            require(_owner != address(0));
            isOwner[_owners[i]] = true;
        }
        owners = _owners;
        confirmationsRequired = _confirmationsRequired;
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value, address(this).balance);
    }

    fallback() external payable{
        emit Deposit(msg.sender, msg.value, address(this).balance);

    }

    function submitTransaction(
        uint _amount,
        address payable _to,
        bytes memory _data
    ) public onlyOwner {
        transactions.push(
            Transaction({
                to: _to,
                amount: _amount, 
                data: _data,
                executed: false,
                numConfirmations: 0
            })
        );
        uint txIndex = transactions.length;

        emit SubmitTransaction(txIndex);
    }

    function approveTransaction(uint _txId)
        public payable
        onlyOwner
        txExists(_txId)
        txNotApproved(_txId)
        txNotExecuted(_txId)
    {
        uint amountEach = _ethersPerOwner(_txId);
        require(msg.value >= amountEach, "You need to send at least your part of ethers");
        transactions[_txId].numConfirmations += 1;
        approved[_txId][msg.sender] = true;

        emit ApproveTransaction(msg.sender, _txId);
    }

    function revokeConfirmation(uint _txId)
        public
        onlyOwner
        txExists(_txId)
        txNotExecuted(_txId)
    {
        require(
            approved[_txId][msg.sender] = true,
            "This Transaction is not approved by the msg.sender"
        );
        approved[_txId][msg.sender] = false;
        transactions[_txId].numConfirmations -= 1;
        uint amountEach = _ethersPerOwner(_txId);
        payable (msg.sender).transfer(amountEach);

        emit RevokeTransaction(msg.sender, _txId);
    }

    function executeTransaction(uint _txId)
        external
        onlyOwner
        txNotExecuted(_txId)
        txExists(_txId)
    {
        Transaction storage transaction = transactions[_txId];
        require(
            transaction.numConfirmations >= confirmationsRequired,
            "Not enough confirmations from the Owners"
        );

        transaction.executed = true;
        (bool success, ) = transaction.to.call{value: _amountCollected(_txId)}(
            transaction.data
        );

        require(success, "tx failed");

        emit ExecuteTransaction(_txId);
    }

    function getOwners() public view returns (address[] memory) {
        return owners;
    }

    function checkExecuted(uint _txId) public view returns (bool) {
        return executed[_txId];
    }

    function getTransactions() public view returns (uint) {
        return transactions.length;
    }

    function getConfirmations(uint _txId) public view returns (uint) {
        uint confirmations = transactions[_txId].numConfirmations;
        return confirmations;
    }

    // Amount per Owner to transfer. Returns Ethers.
    function _ethersPerOwner(uint _txId) public view returns(uint){
        uint ethAmountEach = (transactions[_txId].amount / confirmationsRequired) *10**18;
        return ethAmountEach;
    }

    // Ethers per Owner to claim back in case he approved and now wants to Revoke. Returns Ethers.
    function _ethersRevoke(uint _txId) public view txNotExecuted(_txId) returns(uint){
        require(approved[_txId][msg.sender] == true, "You need to approve to be able to revokate");
        uint ethAmountEach = (transactions[_txId].amount / transactions[_txId].numConfirmations) *10**18;
        return ethAmountEach;
    }

    // Total amount to transfer after all the required confirmations are done. Returns Ethers
    function _amountCollected(uint _txId) public view returns(uint){
        uint totalEthersCollect = (transactions[_txId].amount) *10**18;
        return totalEthersCollect;
    }
}
