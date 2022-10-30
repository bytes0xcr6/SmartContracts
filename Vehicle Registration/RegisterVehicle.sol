// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.4;

import "./Vehicle.sol";
import "./Ownable.sol";

// Register Vehicle contracts
contract RegisterVehicles is Ownable {

    event VehicleRegistered(string plateNum, Vehicle contract_, uint totalAmount);

    mapping(string => Vehicle) registration;
    mapping(Vehicle => bool) registered;
    
    // Total count of Vehicles registered
    uint numVehicles;

    // Store a new Vehicle Smart Contract to the Registration Smart Contract
    function addVehicle(Vehicle _vehicle) public payable onlyOwner{
        require(_vehicle != Vehicle(address(0)));
        require(!registered[_vehicle]);
        string memory _plateNum = Vehicle(_vehicle).getPlateNum();
        registration[_plateNum] =  _vehicle;
        numVehicles++;
        registered[_vehicle] = true;
        emit VehicleRegistered(_plateNum, _vehicle, numVehicles);
    }

    // Get the Vehicle contract with the Plate number
    function getVehicle(string memory _plateNum) public view returns(Vehicle){
        Vehicle _vehicle = registration[_plateNum];
        return _vehicle;
    }
    
    // Check if the Vehicle contract has been registered before
    function isRegistered(Vehicle _vehicle) public view returns(bool) {
        return (registered[_vehicle]);
    }
}
