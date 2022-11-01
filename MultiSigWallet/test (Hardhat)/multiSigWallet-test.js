const { ethers } = require("hardhat");
const { expect } = require("chai");
const { loadFixture } = require("ethereum-waffle");
const { TransactionDescription } = require("ethers/lib/utils");

// Ganache accounts (Testnet):
// 1: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
// 2: 0x70997970C51812dc3A010C7d01b50e0d17dc79C8
// 3: 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC
// 4: 0x90F79bf6EB2c4f870365E785982E1f101E93b906

describe("MultiSigWallet", function () {
  async function deploy() {
    const MultiSigWallet = await ethers.getContractFactory("MultiSigWallet");
    const multiSigWallet = await MultiSigWallet.deploy(
      [
        "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",
        "0x70997970C51812dc3A010C7d01b50e0d17dc79C8",
        "0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC",
      ],
      3
    );
    await multiSigWallet.deployed();

    console.log("* MultiSigWallet contract has been deployed.");
    console.log("* MultiSigWallet contract address:", multiSigWallet.address);

    return { multiSigWallet };
  }

  it("Check the Owners array length", async () => {
    const { multiSigWallet } = await loadFixture(deploy);
    const owners = await multiSigWallet.getOwners();
    expect(owners.length).to.equal(3);
  });

  it("Submit a new transaction", async () => {
    const { multiSigWallet } = await loadFixture(deploy);
    await multiSigWallet.submitTransaction(
      6,
      "0x90F79bf6EB2c4f870365E785982E1f101E93b906",
      "0x6e65775f6d6963726f7761766500000000000000000000000000000000000000"
    );
    const transactions = await multiSigWallet.getTransactions();

    expect(transactions).to.equal(1);
  });

  it("Transfer 5 ethers from the 3 owners to the contract and check SC balance", async () => {
    const { multiSigWallet } = await loadFixture(deploy);
    const [deployer, addr1, addr2] = await ethers.getSigners();
    await deployer.sendTransaction({
      to: multiSigWallet.address,
      value: ethers.utils.parseEther("2.0"),
    });
    await addr1.sendTransaction({
      to: multiSigWallet.address,
      value: ethers.utils.parseEther("2.0"),
    });
    await addr2.sendTransaction({
      to: multiSigWallet.address,
      value: ethers.utils.parseEther("2.0"),
    });

    const ScBalance = await ethers.provider.getBalance(multiSigWallet.address);
    expect(ScBalance).to.equal("6000000000000000000"); // 6000000000000000000 = 6 ethers
  });

  // it("Approve Transaction with the 3 accounts", async () => {
  //   const { multiSigWallet } = await loadFixture(deploy);
  //   const [deployer, addr1, addr2] = await ethers.getSigners();

  //   await multiSigWallet.connect(deployer).approveTransaction(1);
  //   await multiSigWallet.connect(addr1).approveTransaction(1);
  //   await multiSigWallet.connect(addr2).approveTransaction(1);

  //   const confirmations = await multiSigWallet.getConfirmations(1);

  //   expect(confirmations).to.equal(3);
  // });

  it("Execute transaction and check if the amount arrived to the addr 3", async () => {
    const { multiSigWallet } = await loadFixture(deploy);
    const [deployer, addr1, addr2, addr3] = await ethers.getSigners();

    await multiSigWallet.connect(deployer).executeTransaction(1);

    const addr3Balance = await ethers.getBalance(addr3);

    expect(addr3Balance).to.equal("6000000000000000000");
  });

  it("Check Executed value passed to true", async () => {
    const { multiSigWallet } = await loadFixture(deploy);

    const executedValue = await multiSigWallet.checkExecuted(1);

    expect(executedValue).to.equal(true);
  });

  it("Submit new Transaction & confirm it", async () => {
    const { multiSigWallet } = await loadFixture(deploy);
    const [deployer, addr1, addr2] = await ethers.getSigners();

    await multiSigWallet.submitTransaction(
      3,
      "0x90F79bf6EB2c4f870365E785982E1f101E93b906",
      "0x6e65775f6d6963726f7761766500000000000000000000000000000000000000"
    );

    await multiSigWallet.connect(deployer).approveTransaction(2);
    await multiSigWallet.connect(addr1).approveTransaction(2);
    await multiSigWallet.connect(addr2).approveTransaction(2);

    const confirmations = await multiSigWallet.getConfirmations(2);

    expect(confirmations).to.equal(3);
  });

  it("Revoke 1 confirmation from the 3 given", async () => {
    const { multiSigWallet } = await loadFixture(deploy);
    const [deployer, addr1, addr2] = await ethers.getSigners();

    await multiSigWallet.connect(deployer).revokeConfirmation(2);

    const confirmations = await multiSigWallet.getConfirmations(2);

    expect(confirmations).to.equal(2);
  });
});
