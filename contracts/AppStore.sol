pragma solidity ^0.4.4;

import "Owned.sol";
import "AppStoreI.sol";
import "WarehouseI.sol";

contract AppStore is Owned, AppStoreI {
	struct Product {
		string name;
		uint price;	
	}

	mapping(uint => Product) public products;
	uint[] public ids;
	address public warehouse;

	function AppStore(address _warehouse) {
		warehouse = _warehouse;
	}

	function productCount() constant returns (uint length) {
		return ids.length;	
	}

	function addProduct(uint id, string name, uint price)
		fromOwner
		returns (bool successful) {
		products[id] = Product({
			name: name,
			price: price
		});
		ids.push(id);
		LogProductAdded(id, name, price);
		return true;
	}

	function buyProduct(uint id)
		payable
		returns (bool successful) {
		if (msg.value < products[id].price)	{
			throw;
		}
		if (!WarehouseI(warehouse).ship(id, msg.sender)) {
			throw;
		}
		LogProductPurchased(id, msg.sender);
		return true;
	}
}