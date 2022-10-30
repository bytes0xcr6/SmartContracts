// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.4;

// Create new Vehicle contract with all the Vehicle details and the insurance members
contract Vehicle {

    enum TypeVehicle {
        CAR,
        TRUCK,
        BUS
    }

    uint8 public doorNum;
    bool public isPetrol;
    address private owner;
    TypeVehicle public typeVehicle;
    string public plateNumber;
    string public model;
    address[] private insuredPeople;

    constructor(uint8 doorNum_, bool isPetrol_, address owner_, TypeVehicle typeVehicle_, string memory plateNumber_, string memory model_) {
        require(bytes(plateNumber_).length > 0);
        require(doorNum_ > 0);
        doorNum = doorNum_;
        isPetrol = isPetrol_;
        plateNumber = plateNumber_;
        owner = owner_;
        typeVehicle = typeVehicle_;
        model = model_;
        insuredPeople.push(owner_);
    }
    
    // Add people to the insurance
    function addInsuredPeople(address newInsured_) public {
        insuredPeople.push(newInsured_);
    }

    // Get the Owner of the Car
    function getOwner() public view returns(address) {
        return (owner);
    }

    // Get the plane Number of the Car
    function getPlateNum() public view returns(string memory){
        return (plateNumber);
    }

    // Get the Fuel type
    function getFuel() public view returns(string memory){
        if(isPetrol){
            return ("PETROL");
        }else{
            return("DIESEL");
        }
    }
    
    function insuredPeopleLength() public view returns (uint) {
        return insuredPeople.length;
    }
}
