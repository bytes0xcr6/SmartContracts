const Vehicle = artifacts.require("Vehicle");
const RegisterVehicles = artifacts.require("RegisterVehicles");

contract("Vehicle", accounts => {
    console.log(accounts);

        // Check the Owner
    it("getOwner", async() => {
        let instance = await Vehicle.deployed();

        let owner = await instance.getOwner();
        assert.equal(owner, accounts[0]);
    });

    // Check the Plate number
    it("getPlateNumber", async() => {
        let instance = await Vehicle.deployed();

        let plateNumber = await instance.getPlateNum();
        assert.equal("CR6", plateNumber);
    })

    // Check the Fuel type
    it("getFuel", async()=> {
        let instance = await Vehicle.deployed();

        let fuel = await instance.getFuel();
        assert.equal(fuel, "PETROL");
    })

    // Check if the new address was added to the Insurance array
    it("check Insurance", async() => {
        let instance = await Vehicle.deployed();
        await instance.addInsuredPeople("0xd9a3a480559Eb0767CC5dF3019571D8AB5695445");

        let length = await instance.insuredPeopleLength();
        assert.equal(length, 2);
    })

})

// Vehicle address deployed in the Ganache: 0x78297A2900b4aE49b4f11Ef92557a99135eeD94B
contract("RegisterVehicles", accounts => {

    // // Register a new Vehicle contract and check if it was added (Account used is NOT the Owner). 
    // // It will trigger an error as you are not the Owner.
    // it("Add vehicles not Owner", async() => {
    //     let instance = await RegisterVehicles.deployed();

    //     await instance.addVehicle("0x78297A2900b4aE49b4f11Ef92557a99135eeD94B", {from: accounts[1]});

    //     let isRegistered = await instance.isRegistered("0x78297A2900b4aE49b4f11Ef92557a99135eeD94B");
    //     assert.notEqual(true, isRegistered);
    // })

    // Register a new Vehicle contract and check if it was added (Account used is the Owner)
    it("Add Vehicles Owner & Check it", async() => {
        let instance = await RegisterVehicles.deployed();

        await instance.addVehicle("0x78297A2900b4aE49b4f11Ef92557a99135eeD94B");

        let isRegistered = await instance.isRegistered("0x78297A2900b4aE49b4f11Ef92557a99135eeD94B");
        assert.equal(true, isRegistered);
    })

})
