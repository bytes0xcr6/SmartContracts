const { ethers } = require("hardhat");
const { expect } = require("chai");
const { loadFixture } = require("ethereum-waffle");

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
      9,
      "0x90F79bf6EB2c4f870365E785982E1f101E93b906",
      "0x6e65775f6d6963726f7761766500000000000000000000000000000000000000"
    );
    const transactions = await multiSigWallet.getTransactions();

    expect(transactions).to.equal(1);
  });

  it("Approve Transaction with the 3 accounts", async () => {
    const { multiSigWallet } = await loadFixture(deploy);
    const [deployer, addr1, addr2] = await ethers.getSigners();

    await multiSigWallet
      .connect(deployer)
      .approveTransaction(0, { value: ethers.utils.parseEther("3") });
    await multiSigWallet
      .connect(addr1)
      .approveTransaction(0, { value: ethers.utils.parseEther("3") });
    await multiSigWallet
      .connect(addr2)
      .approveTransaction(0, { value: ethers.utils.parseEther("3") });

    const confirmations = await multiSigWallet.getConfirmations(0);

    expect(confirmations).to.equal(3);
  });

  it("Execute transaction and check if the amount arrived to the addr 3", async () => {
    const { multiSigWallet } = await loadFixture(deploy);
    const [deployer, addr1, addr2, addr3] = await ethers.getSigners();

    const addr3BalanceBefore = await ethers.provider.getBalance(
      "0x90F79bf6EB2c4f870365E785982E1f101E93b906"
    );

    await multiSigWallet.connect(deployer).executeTransaction(0);

    const addr3BalanceAfter = await ethers.provider.getBalance(
      "0x90F79bf6EB2c4f870365E785982E1f101E93b906"
    );

    const addr3FinalBalance = addr3BalanceAfter - addr3BalanceBefore;

    expect(addr3FinalBalance).to.be.greaterThan(8000000000000000000);
  });

  it("Check Executed value passed to true", async () => {
    const { multiSigWallet } = await loadFixture(deploy);

    const executedValue = await multiSigWallet.checkExecuted(0);

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

    await multiSigWallet
      .connect(deployer)
      .approveTransaction(1, { value: ethers.utils.parseEther("3") });
    await multiSigWallet
      .connect(addr1)
      .approveTransaction(1, { value: ethers.utils.parseEther("3") });
    await multiSigWallet
      .connect(addr2)
      .approveTransaction(1, { value: ethers.utils.parseEther("3") });

    const confirmations = await multiSigWallet.getConfirmations(1);

    expect(confirmations).to.equal(3);
  });

  it("Revoke 1 confirmation from the 3 given", async () => {
    const { multiSigWallet } = await loadFixture(deploy);
    const [deployer, addr1, addr2] = await ethers.getSigners();

    await multiSigWallet.connect(deployer).revokeConfirmation(1);

    const confirmations = await multiSigWallet.getConfirmations(1);

    expect(confirmations).to.equal(2);
  });
});
