const MultiSigWallet = artifacts.require("MultiSigWallet");

// Example of Bytes for the test: 0x6e65775f6d6963726f7761766500000000000000000000000000000000000000

contract("MultiSigWallet", (accounts) => {
  console.log("Accounts:", accounts);

  it("Deploy contract & Get owners", async () => {
    const instance = await MultiSigWallet.deployed(
      [accounts[0], accounts[1], accounts[2]],
      3
    );

    const owners = await instance.getOwners();

    assert.equal(owners.length, 3);
  });

  it("Submit transaction & get transaction", async () => {
    const instance = await MultiSigWallet.deployed();

    await instance.submitTransaction(
      9,
      accounts[3],
      "0x6e65775f6d6963726f7761766500000000000000000000000000000000000000"
    );

    const transactions = await instance.getTransactions();

    assert.equal(transactions, 1);
  });

  it("Transfer 6 ethers to the Smart Contract from the owners", async () => {
    const instance = await MultiSigWallet.deployed();

    const valueEther = 3;

    const valueWei = await web3.utils.toWei(String(valueEther, "ether"));

    await web3.eth.sendTransaction({
      to: instance.address,
      from: accounts[0],
      value: valueWei,
    });
    await web3.eth.sendTransaction({
      to: instance.address,
      from: accounts[1],
      value: valueWei,
    });
    await web3.eth.sendTransaction({
      to: instance.address,
      from: accounts[2],
      value: valueWei,
    });

    const scBalance = await web3.eth.getBalance(instance.address);

    assert.equal(scBalance, "9000000000000000000");
    console.log("The contract balance now is:", scBalance);
    const balanceAccount3 = await web3.eth.getBalance(accounts[3]);
    console.log("The balance of receiver is now:", balanceAccount3);
  });

  it("Approve transactions and revoke", async () => {
    const instance = await MultiSigWallet.deployed();

    const valueWei = await web3.utils.toWei(String(3, "ether"));
    // Approve 3 times
    await instance.approveTransaction(0, {
      from: accounts[0],
      value: valueWei,
    });
    await instance.approveTransaction(0, {
      from: accounts[1],
      value: valueWei,
    });
    await instance.approveTransaction(0, {
      from: accounts[2],
      value: valueWei,
    });

    // Revoke 1 time
    await instance.revokeConfirmation(0, { from: accounts[0] });

    const confirmations = await instance.getConfirmations(0);

    assert.equal(2, confirmations);
  });

  it("Approve back to have 3 confirmations and executeTransaction", async () => {
    const instance = await MultiSigWallet.deployed();

    const valueWei = await web3.utils.toWei(String(3, "ether"));

    await instance.approveTransaction(0, {
      from: accounts[0],
      value: valueWei,
    });

    const balanceReceiverBefore = await web3.eth.getBalance(accounts[3]);
    await instance.executeTransaction(0);

    const balanceReceiverAfter = await web3.eth.getBalance(accounts[3]);
    const finalBalance = balanceReceiverAfter - balanceReceiverBefore;

    // const scBalance = await web3.eth.getBalance(instance.address);

    assert.equal("9000000000000000000", finalBalance);
    console.log("The total balance of account 3 now is:", finalBalance);
  });
});
