pragma solidity ^0.4.8;
//Smart contract handles publishing STR every epoch
contract Trusternity
{	
	//An Identity Provider struct contains a provider name, 
	//a public key fingerprint and a List of STR	
	struct IdentityProvider{
		string Name;
		bytes Fingerprint;
		mapping(uint => bytes) RootList;
	}

	//List of all IdentityProvider
	mapping(address => IdentityProvider) public IdentityProviderList;
	
	//An IdentityProvider registers itself to the system by providing 
	//its name and its key fingerprint.
	//TODO: Make sure the combination is unique	
	function Register(string identityProviderName, bytes fingerprint){
		IdentityProviderList[msg.sender].Name = identityProviderName;
		IdentityProviderList[msg.sender].Fingerprint = fingerprint;
	}

	//An IdentityProvider publishes the STR every epoch.
	//The STR is mapped to its timeStamp 
	function Publish(uint timeStamp, bytes STR) {
		IdentityProviderList[msg.sender].RootList[timeStamp] = STR;		
	}              	
}
