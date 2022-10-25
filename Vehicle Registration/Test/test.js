const Vehicle = artifacts.require("Vehicle");
const RegisterVehicles = artifacts.require("RegisterVehicles");

contract("Vehicle", accounts => {
    console.log(accounts);

    it("getOwner", async() => {
        let instance = await Vehicle.deployed();

        let owner = await instance.getOwner();
        assert.equal(owner, accounts[0]);
    });

    it("getPlateNumber", async() => {
        let instance = await Vehicle.deployed();

        let plateNumber = await instance.getPlateNum();
        assert.equal("hola6", plateNumber);
    })

    it("getFuel", async()=> {
        let instance = await Vehicle.deployed();

        let fuel = await instance.getFuel();
        assert.equal(fuel, "PETROL");
    })

    it("check Insurance", async() => {
        let instance = await Vehicle.deployed();
        await instance.addInsuredPeople("0xd9a3a480559Eb0767CC5dF3019571D8AB5695445");

        let length = await instance.insuredPeopleLength();
        assert.equal(length, 2);
    })

})

// Vehicle address deployed in the Ganache: 0x78297A2900b4aE49b4f11Ef92557a99135eeD94B
contract("RegisterVehicles", accounts => {

    //// If you test to add with an account that is not the Owner.
    // it("Add vehicles not Owner", async() => {
    //     let instance = await RegisterVehicles.deployed();

    //     await instance.addVehicle("0x78297A2900b4aE49b4f11Ef92557a99135eeD94B", {from: accounts[1]});

    //     let isRegistered = await instance.isRegistered("0x78297A2900b4aE49b4f11Ef92557a99135eeD94B");
    //     assert.notEqual(true, isRegistered);
    // })

    it("Add Vehicles Owner & Check it", async() => {
        let instance = await RegisterVehicles.deployed();

        await instance.addVehicle("0x78297A2900b4aE49b4f11Ef92557a99135eeD94B");

        let isRegistered = await instance.isRegistered("0x78297A2900b4aE49b4f11Ef92557a99135eeD94B");
        assert.equal(true, isRegistered);
    })

})
