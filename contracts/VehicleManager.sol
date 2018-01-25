pragma solidity ^0.4.15;
contract VehicleManager  {

    	address owner;
        bytes32[]  vins;
        mapping(bytes32 => Vehicle) vehicleMap;

        function VehicleManager(){
            owner = msg.sender;
        }

        event NewVehicle(bytes32 _vin,string vowner);

    	struct Vehicle {
		    bytes32 vin;
		    string year;
		    string model;
		    string make;
		    string vehicleOwner;
	    	int8 status;  //  0 not exist, 1 created, 2 transferred...

	    }
        modifier isOnwer(address sender) {
            if(owner != sender) {
                revert;
            }else{
                _;
            }
        }

        function registerVehicle(bytes32 _vin,string _year,string _model,string _make,string _vonwer) isOnwer(msg.sender) public{

            require(!isVehicle(_vin));
            vins.push(_vin);
            vehicleMap[_vin] = Vehicle(_vin,_year,_model, _make,_vonwer, 1);
        }

        function isVehicle(bytes32 _id) public constant returns(bool) {
		if (vehicleMap[_id].status != 0) {
			return true;
		    }

	        return false;
	    }


	    function transferVehicle(bytes32 _vin,string _voner) public isOnwer(msg.sender) returns(string)  {
	        require(isVehicle(_vin));
            vehicleMap[_vin].vehicleOwner = _voner;
            vehicleMap[_vin].status = 2;


	    }
	    function getVehicleOnwer(bytes32 _id) public constant returns(string){
	        require(isVehicle(_id));
	        string storage name= vehicleMap[_id].vehicleOwner;
	        return name;
	    }

	    /**
	    function serviceHistory(bytes32 _id) public returns (string[]){
	        // to be implemented
	    }
        **/
}
