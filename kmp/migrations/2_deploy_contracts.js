var Platform = artifacts.require("Platform");
var Owned = artifacts.require("Owned");
var CompanyFactory = artifacts.require("CompanyFactory");
var CompanyUtil = artifacts.require("CompanyUtil");
var TokenFactory = artifacts.require("TokenFactory");
var TokenUtil = artifacts.require("TokenUtil");
var Token = artifacts.require("Token");

module.exports = function(deployer, network, accounts) {
  deployer.deploy(Owned);
  deployer.deploy(CompanyFactory);
  deployer.deploy(CompanyUtil);
  deployer.link(CompanyUtil, TokenUtil);
  deployer.deploy(TokenUtil);

  deployer.link(CompanyFactory, TokenFactory);
  deployer.link(CompanyUtil, TokenFactory);
  deployer.deploy(TokenFactory);

  deployer.link(TokenFactory, Platform);
  deployer.link(CompanyFactory, Platform);
  deployer.link(CompanyUtil, Platform);
  deployer.link(CompanyFactory, Platform);
  deployer.link(TokenUtil, Platform);
  deployer.deploy(Platform);
  
  deployer.deploy(Token, "0x31b98d14007bdee637298086988a0bbd31184523", accounts[0], "Tokenizer", "TKN", 1000);

 
};