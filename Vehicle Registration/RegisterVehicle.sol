// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.4;

contract RegisterVehicles is Ownable {

    event VehicleRegistered(string plateNum, Vehicle contract_, uint totalAmount);

    mapping(string => Vehicle) registration;
    mapping(Vehicle => bool) registered;
    
    uint numVehicles;

    function addVehicle(Vehicle _vehicle) public payable onlyOwner{
        require(_vehicle != Vehicle(address(0)));
        require(!registered[_vehicle]);
        string memory _plateNum = Vehicle(_vehicle).getPlateNum();
        registration[_plateNum] =  _vehicle;
        numVehicles++;
        emit VehicleRegistered(_plateNum, _vehicle, numVehicles);
    }

    function getVehicle(string memory _plateNum) public view returns(Vehicle){
        Vehicle _vehicle = registration[_plateNum];
        return _vehicle;
    }
}
