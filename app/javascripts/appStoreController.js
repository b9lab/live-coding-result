var app = angular.module('appStoreApp', []);

app.config(function ($locationProvider) {
  $locationProvider.html5Mode(true);
});

app.controller("appStoreController", [ '$scope', '$location', '$http', '$q', '$window', '$timeout', function($scope , $location, $http, $q, $window, $timeout) {
    
	$scope.addProduct = function(newId, newName, newPrice) {

		AppStore.deployed()
			.addProduct(
				newId,
				newName,
				newPrice,
				{ from: account, gas: 3000000 })
			.then(function (tx) {
				return web3.eth.getTransactionReceiptMined(tx);
			})
			.then(function (receipt) {
				console.log("product added");
			});

	};

	$scope.products = [];

	$scope.collectProducts = function() {

		AppStore.deployed().getProductCount()
			.then(function (count) {
				if (count.valueOf() > 0) {
					for (var i = 0; i < count.valueOf(); i++) {
						AppStore.deployed().getProductIdAt(i)
							.then(function (id) {
								return AppStore.deployed().getProduct(id.valueOf())
									.then(function (values) {
										$timeout(function () {
											$scope.products.push({
												id: id,
												name: values[0],
												price: values[1]
											});
										});
									})
									.catch(function (e) {
										console.error(e);
									});
							})
							.catch(function (e) {
								console.error(e);
							});
					}
				}
			});

	};

	$window.onload = function () {

		initUtils(web3);
		web3.eth.getAccounts(function(err, accs) {
			if (err != null) {
			  alert("There was an error fetching your accounts.");
			  return;
			}

			if (accs.length == 0) {
			  alert("Couldn't get any accounts! Make sure your Ethereum client is configured correctly.");
			  return;
			}

			accounts = accs;
			account = accounts[0];

		});		

		$scope.collectProducts();

	}

}]);