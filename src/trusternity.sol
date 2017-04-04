pragma solidity ^0.4.8;
//Smart contract handles publishing STR every epoch
contract Trusternity
{	
	//An Identity Provider struct contains a provider name, 
	//a public key fingerprint and a List of STR	
	struct Provider{		
		string name;
		bytes32 fingerprint;		
		mapping(uint64 => bytes32) rootList;
	}	

	//List of all Provider
	mapping(address => Provider) public ProviderList;	

	//An Identity Provider registers itself to the system by providing 
	//its name and its key fingerprint.	
	function Register(string _name, bytes32 _fprint){
		ProviderList[msg.sender].name = _name;
		ProviderList[msg.sender].fingerprint = _fprint;	
	}

	//An Provider publishes the STR every epoch.
	//The STR is mapped to its timeStamp 
	function Publish(uint64 epoch, bytes32 STR) {		
		ProviderList[msg.sender].rootList[epoch] = STR;		
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
