const Vehicle = artifacts.require("Vehicle");
const RegisterVehicles = artifacts.require("RegisterVehicles");
const Ownable = artifacts.require("Ownable");

module.exports = function(deployer) {
    deployer.deploy(Vehicle,2, true, "0xc5B46eaAb07Bdf4D28e3120694C98288b7c4cEBf", 1, "CR6", "Mercedes");
    deployer.deploy(Ownable);
    deployer.link(RegisterVehicles, Ownable);
    deployer.deploy(RegisterVehicles);
}
