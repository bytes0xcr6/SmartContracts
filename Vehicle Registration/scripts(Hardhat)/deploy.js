const hre = require("hardhat");

async function main() {
  await hre.run("compile");

  const deployer = await hre.ethers.getSigner();

  const Vehicle = await hre.ethers.getContractFactory("Vehicle");
  // account 0 (Ganache): 0x14703Bb3abdA75bE83cc2E9aEE45E8A3952714E3
  const vehicle = await Vehicle.deploy(
    5,
    true,
    "0x14703Bb3abdA75bE83cc2E9aEE45E8A3952714E3",
    0,
    "CR6",
    "Mercedes"
  );

  await vehicle.deployed();

  console.log("-Vehicle is deployed");
  console.log("Vehicle contract address:", vehicle.address);
  console.log("-------------");

  const Ownable = await hre.ethers.getContractFactory("Ownable");
  const ownable = await Ownable.deploy();

  await ownable.deployed();

  console.log("-Ownable is deployed");
  console.log("Ownable contract address:", ownable.address);
  console.log("Deployer address is:", deployer.address);
  console.log("-------------");

  const RegisterVehicle = await hre.ethers.getContractFactory(
    "RegisterVehicles"
  );
  const registerVehicle = await RegisterVehicle.deploy();
  await registerVehicle.deployed();
  console.log("-RegisterVehicle is deployed");
  console.log("RegisterVehicle contract address:", registerVehicle.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
