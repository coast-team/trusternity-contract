pragma solidity ^0.4.8;
// Smart contract handles publishing STR every epoch
// As described in https://media.consensys.net/technical-introduction-to-events-and-logs-in-ethereum-a074d65dd61e
// STR can be cheaply stored using event. It is also more suitable for the light client to query full client 
// using LogsBloom and transaction log. Without this, it is extremely hard for the client to execute query function.
// The question is, should we continue keeping the storage mapping ?
contract Trusternity
{	
	event Published(
        address indexed _from,		
        uint64 indexed _epoch,
        bytes32 _strValue
    );

	//An Identity Provider struct contains a provider name, 
	//a public key fingerprint and a List of STR	
	struct Provider{	
		bool registered;
		string name;
		bytes32 fingerprint;		
		uint64 lastepoch;
		mapping(uint64 => bytes32) rootList;
	}	

	//List of all Provider
	mapping(address => Provider) public ProviderList;	

	//An Identity Provider registers itself to the system by providing 
	//its name and its key fingerprint.	
	function Register(string _name, bytes32 _fprint){
		if (!ProviderList[msg.sender].registered){
			ProviderList[msg.sender].registered = true;
			ProviderList[msg.sender].name = _name;
			ProviderList[msg.sender].fingerprint = _fprint;	
			ProviderList[msg.sender].lastepoch = 0;	
		}
	}

	//An Provider publishes the STR every epoch.
	//The STR is mapped to its timeStamp 
	function Publish(uint64 epoch, bytes32 STR) {
		if (ProviderList[msg.sender].registered 
			&& ProviderList[msg.sender].lastepoch < epoch){	
			ProviderList[msg.sender].rootList[epoch] = STR;
			ProviderList[msg.sender].lastepoch = epoch;	
			Published(msg.sender, epoch, STR);
		}
	}

	function GetProviderName(address _ads) returns (string){
		return ProviderList[_ads].name;
	}

	function GetProviderFingerprint(address _ads) returns (bytes32){
		return ProviderList[_ads].fingerprint;
	}

	function GetSTR(address _ads, uint64 epoch) returns (bytes32){
		return ProviderList[_ads].rootList[epoch];
	}
}
