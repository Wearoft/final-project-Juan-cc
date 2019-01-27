final-project-Juan-cc
=====================
[![Build Status](https://travis-ci.org/Wearoft/final-project-Juan-cc.svg?branch=master)](https://travis-ci.org/Wearoft/final-project-Juan-cc)
[![Coverage Status](https://coveralls.io/repos/github/Wearoft/final-project-Juan-cc/badge.svg?branch=master)](https://coveralls.io/github/Wearoft/final-project-Juan-cc?branch=master)

  
# Documentation
* Description: https://docs.google.com/document/d/1Q8KoQVWiCFN1jqC8iK3s12gHI_9GBJevjq5aGZrJqHI/edit?usp=sharing
* Company Creation Diagram:https://drive.google.com/file/d/1YlAX9PJoqXrYRPz8QWjek3gCbtOwsT8S/view?usp=sharing
* Token Creation Diagram: https://drive.google.com/file/d/1XPeKMUTQRmNga701XV7o2m7x72-q4bqy/view?usp=sharing
* Token Transfer Diagram: https://drive.google.com/file/d/1PpXvaiI5DEarzPvsQgStGnJ73633Y0EP/view?usp=sharing


## Prerequisites
- Truffle v5.0.0 (core: 5.0.0)
- Solidity v0.5.0 (solc-js)
- Node v8.10.0
- Web3 ^1.0.0-beta.35

## Play on Rinkeby
- start your browser and authenticate metamask to Rinkeby
- go to https://kmpblockchain.herokuapp.com/
- Play with it!
- _tip: when using the dApp open browser's developer console and wait until the confirmation is confirmed before pressing another button._ 

## Run Locally
### Setup
  - download project source code.
  - go to /final-project-Juan-cc/kmp and run: **npm install**
  - go to /final-project-Juan-cc/kmp/client and run: **npm install && npm run link-contracts**
  - start ganache on port 8545
### Unit Testing
  - _tip: if you have a symbolic link called "contracts" inside /final-project-Juan-cc/kmp/build/contracts, then please delete that link to avoid the error described below (*1)_  
  - on /final-project-Juan-cc/kmp run: **truffle migrate --reset --all**
  - on /final-project-Juan-cc/kmp run: **truffle test** (here you can validate unit tests)
### dApp
  - start a browser and authenticate metamask to your local ganache (using your 12 words seed and password)
  - go to /final-project-Juan-cc/kmp/client and run: **npm run start** (here you can validate web3 interaction with dApp)
  - Play with your dApp!

### Code Coverage
  - replace this file: /final-project-Juan-cc/kmp/node_modules/solidity-parser-sc/build/parser.js with this one: https://raw.githubusercontent.com/maxsam4/solidity-parser/solidity-0.5/build/parser.js 
  - on /final-project-Juan-cc/kmp run: npm run coverage (here you can validate code coverage)

## Used library:
- "openzeppelin-solidity": "2.1.2"

## Created libraries
- CompanyFactory.sol
- TokenFactory.sol

## Network: rinkeby (id: 4)
*  CompanyFactory: 0x5e24831D4B84304DB083B3F0224320aB52213fee
*  CompanyUtil: 0xCa901C6634dF9cf2E37b5b14C1A6eDA52520562C
*  Migrations: 0x5A94c5E882ae6E07788347B62cC14Dace222d545
*  Owned: 0x531C97656F21937A47c36076F62571a25e4BA073
*  Platform: 0x3Ff3962A9Ce8bdeA7224C5307bE8597AdA04522B
*  Token: 0x151E0a708928F2f39ADfBeaB3B32dc6E02B7Ec99
*  TokenFactory: 0xebE2b81EB84EB34d0a67f6025433C17AfF7bF339
*  TokenUtil: 0x26C204F03b5c9ad20626E4e764CF9E6528c543e6



### Code Coverage useful link to fix parser
- https://github.com/sc-forks/solidity-parser/pull/18 (solidity-coverage)

### Symbolic link error (*1)
  fs.js:675
    return binding.read(fd, buffer, offset, length, position);
                   ^
  Error: EISDIR: illegal operation on a directory, read

