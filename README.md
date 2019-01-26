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
*  CompanyFactory: 0x935D2cBC4Fde6A6b7ff9FC2F2E480655Ddd2C1F3
*  Migrations: 0x4777c451296EB87537e53921f04e48833D0d1694
*  Owned: 0x6b7978958f75D5f004A0f403D8B1A25Dd66cDF2E
*  Platform: 0xfb9f2c314b4d2518Ee892751358B0383C6D5E4F4
*  Token: 0xde01876924d8c752b00a8500344F10E6988EA7fB
*  TokenFactory: 0x51677cD1145818ad4a291e92ee08f9EC473C1C31



### Code Coverage useful link to fix parser
- https://github.com/sc-forks/solidity-parser/pull/18 (solidity-coverage)

### Symbolic link error (*1)
  fs.js:675
    return binding.read(fd, buffer, offset, length, position);
                   ^
  Error: EISDIR: illegal operation on a directory, read

