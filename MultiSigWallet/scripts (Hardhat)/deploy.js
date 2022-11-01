const hre = require("hardhat");

// Ganache accounts (Testnet):
// 1: 0x14703Bb3abdA75bE83cc2E9aEE45E8A3952714E3
// 2: 0x5DaA62590F53EE139Db36A75C5a40296D47D5Bf2
// 3: 0x6AB460491b6f6Af21E9B9C06C3F908a4c1D268F7
// 4: 0xd90904352b086f936aC9E1c6d5Ec288c324dD707

async function main() {
  const MultiSigWallet = await hre.ethers.getContractFactory("MultiSigWallet");
  const multiSigWallet = await MultiSigWallet.deploy(
    [
      "0x14703Bb3abdA75bE83cc2E9aEE45E8A3952714E3",
      "0x5DaA62590F53EE139Db36A75C5a40296D47D5Bf2",
      "0x6AB460491b6f6Af21E9B9C06C3F908a4c1D268F7",
    ],
    3
  );
  await multiSigWallet.deployed();

  console.log("* MultiSigWallet contract has been deployed.");
  console.log("* MultiSigWallet contract address:", multiSigWallet.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
