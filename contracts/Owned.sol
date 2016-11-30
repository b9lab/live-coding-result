pragma solidity ^0.4.4;

contract Owned {
	address public owner;

	function Owned() {
		owner = msg.sender;	
	}

	modifier fromOwner {
		if (msg.sender != owner) throw;
		_;
	}
}