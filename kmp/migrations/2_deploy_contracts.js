var Platform = artifacts.require("Platform");
var Owned = artifacts.require("Owned");
var CompanyFactory = artifacts.require("CompanyFactory");
var TokenFactory = artifacts.require("TokenFactory");
var Token = artifacts.require("Token");

module.exports = function(deployer, network, accounts) {
  deployer.deploy(Owned);
  deployer.deploy(CompanyFactory);
  deployer.link(CompanyFactory, TokenFactory);
  deployer.deploy(TokenFactory);
  deployer.link(CompanyFactory, Platform);
  deployer.link(TokenFactory, Platform);
  deployer.deploy(Platform);
  deployer.deploy(Token, "0x31b98d14007bdee637298086988a0bbd31184523", accounts[0], "Tokenizer", "TKN", 1000);

 
};