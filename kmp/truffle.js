var infura = "https://rinkeby.infura.io/v3/6125978bbbb14d4f968db4ae027bb2ed"
var HDWalletProvider = require("truffle-hdwallet-provider")
var mnemonic = "script viable circle vessel argue doll page clay practice toddler fiction attitude";

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!

  networks: {
    development: {
      host: '127.0.0.1',
      port: 8545,
      network_id: '*' // Match any network id
    },
    rinkeby: {
      provider: new HDWalletProvider(mnemonic, infura),
      network_id: "4",
      gas: 6995427
    }
  }
};