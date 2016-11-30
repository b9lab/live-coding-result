module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.autolink();
  deployer.deploy(MetaCoin);
  deployer.deploy(Warehouse)
  	.then(function () {
  		return deployer.deploy(AppStore, Warehouse.address);
  	});  
  
};
