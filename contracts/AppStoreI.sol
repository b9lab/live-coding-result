pragma solidity ^0.4.4;

contract AppStoreI {
	event LogProductAdded(uint id, string name, uint price);
	event LogProductPurchased(uint id, address customer);

	function getProductCount()
		constant
		returns (uint length);

	function getProductIdAt(uint index)
		constant
		returns (uint id);

	function getProduct(uint id)
		constant
		returns (string name, uint price);

	function addProduct(uint id, string name, uint price)
		returns (bool successful);

	function buyProduct(uint id)
		payable
		returns (bool successful);
}