final-project-Juan-cc
=====================
[![Build Status](https://travis-ci.org/Wearoft/final-project-Juan-cc.svg?branch=master)](https://travis-ci.org/Wearoft/final-project-Juan-cc)
[![Coverage Status](https://coveralls.io/repos/github/Wearoft/final-project-Juan-cc/badge.svg?branch=master)](https://coveralls.io/github/Wearoft/final-project-Juan-cc?branch=master)
[![Known Vulnerabilities](https://snyk.io/test/github/Wearoft/final-project-Juan-cc/badge.svg)](https://snyk.io/test/github/Wearoft/final-project-Juan-cc)

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

## Run Locally
### Setup
  - download project source code.
  - go to /final-project-Juan-cc/kmp and run: **npm install**
  - go to /final-project-Juan-cc/kmp/client and run: **npm install && npm run link-contracts**
  - start ganache on port 8545
### Unit Testing
  - tip: if you have a symbolic link called "contracts" inside /final-project-Juan-cc/kmp/build/contracts, then please delete that link to avoid the error described below *1  
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
*  CompanyFactory: 0x86583B84A44bC80716F3CA122a615005806FDC2c
*  KMP: 0x22A38A76CC9571482Ad9Df4dac9D4fAFdcCc3c6c
*  KMToken: 0xac5D27B6DA9705CF35d5B78b722e3cdF5001865D
*  Migrations: 0x04b39e3457Df012FBA2ad893D6f66c3D176ac54b
*  Owned: 0x22DCe77dC1Aa86c020E24268FaA9c1a965Bd94D2
*  TokenFactory: 0x352F93925Ba3a1eBbA851963A153cdaa5Ac105f5


### Code Coverage useful link to fix parser
- https://github.com/sc-forks/solidity-parser/pull/18 (solidity-coverage)

### Symbolic link error (*1)
  fs.js:675
    return binding.read(fd, buffer, offset, length, position);
                   ^
  Error: EISDIR: illegal operation on a directory, read

