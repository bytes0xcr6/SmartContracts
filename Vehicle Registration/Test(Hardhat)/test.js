const { expect } = require("chai");
const { ethers } = require("hardhat");
const { loadFixture } = require("ethereum-waffle");

describe("Vehicle & RegisterVehicle tests", async function () {
  // CONTRACTS DEPLOYMENT
  async function deployContracts() {
    // Deploy Ownable
    const Ownable = await ethers.getContractFactory("Ownable");
    const ownable = await Ownable.deploy();
    await ownable.deployed();
    console.log("Ownable contract deployed:", ownable.address);

    // Deploy Vehicle
    const Vehicle = await ethers.getContractFactory("Vehicle");
    const vehicle = await Vehicle.deploy(
      5,
      true,
      "0x14703Bb3abdA75bE83cc2E9aEE45E8A3952714E3",
      0,
      "CR6",
      "Mercedes"
    );
    await vehicle.deployed();
    const vehicleAddress = vehicle.address;
    console.log("Vehicle contract deployed:", vehicle.address);

    // Deploy RegisterVehicle
    const RegisterVehicles = await ethers.getContractFactory(
      "RegisterVehicles"
    );
    const registerVehicles = await RegisterVehicles.deploy();
    await registerVehicles.deployed();
    console.log("RegisterVehicle contract deployed:", registerVehicles.address);

    return { vehicle, registerVehicles, vehicleAddress, ownable };
  }

  // *** Vehicle contract TESTS
  it("* Check the owner matches with the deployer.", async () => {
    const { vehicle } = await loadFixture(deployContracts);
    const owner = await vehicle.getOwner();

    expect("0x14703Bb3abdA75bE83cc2E9aEE45E8A3952714E3").to.equal(owner);
    console.log("The owner is:", owner);
  });

  it("* Check the person is added to the array.", async () => {
    const { vehicle } = await loadFixture(deployContracts);

    // add an address to the insuredPeople array
    // Account 1 (Ganache): 0x5DaA62590F53EE139Db36A75C5a40296D47D5Bf2
    await vehicle.addInsuredPeople(
      "0x5DaA62590F53EE139Db36A75C5a40296D47D5Bf2"
    );
    const insuredPeopleArray = await vehicle.insuredPeopleLength();
    expect(2).to.equal(insuredPeopleArray);
  });

  // *** RegisterVehicle contract TESTS
  it("* Register Vehicle contract and check it was added to the array", async () => {
    const { registerVehicles, vehicleAddress } = await loadFixture(
      deployContracts
    );

    // Add Vehicle contract to the Vehicle registered array
    await registerVehicles.addVehicle(vehicleAddress);

    // Check if it was registered
    const isRegistered = await registerVehicles.isRegistered(vehicleAddress);
    expect(true).to.equal(isRegistered);
  });

  it("* Get the Vehicle contract with the Plate number", async () => {
    const { registerVehicles, vehicleAddress } = await loadFixture(
      deployContracts
    );

    const vehicleRegistered = await registerVehicles.getVehicle("CR6");
    expect(vehicleAddress).to.equal(vehicleRegistered);
  });
});
