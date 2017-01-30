contract Trusternity
{
	struct Certificate{                           
		string domain;
		string STR;
	}
	mapping(address => Certificate) public CertificateList;
	
	function Publish(string name, string value) {         
		CertificateList[msg.sender].domain = name;
		CertificateList[msg.sender].STR = value;
	}              
	
	function query(address dom) returns (string val){
		return CertificateList[dom].STR;
	}
}
