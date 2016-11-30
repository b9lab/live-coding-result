pragma solidity ^0.4.4;

contract WarehouseI {
	function ship(uint id, address customer)
		returns (bool success);
}