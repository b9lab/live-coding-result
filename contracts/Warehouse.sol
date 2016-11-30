pragma solidity ^0.4.4;

import "WarehouseI.sol";

contract Warehouse is WarehouseI {
	function ship(uint id, address customer)
		returns (bool success) {
		return true;		
	}
}