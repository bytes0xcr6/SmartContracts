
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

    function addInsuredPeople(address newInsured_) public {
        insuredPeople.push(newInsured_);
    }

    function getOwner() public view returns(address) {
        return (owner);
    }

    function getPlateNum() public view returns(string memory){
        return (plateNumber);
    }

    function getCombustible() public view returns(string memory){
        if(isPetrol){
            return ("PETROL");
        }else{
            return("DIESEL");
        }
    }
}
