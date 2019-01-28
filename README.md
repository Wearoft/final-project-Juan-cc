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

## Play on Rinkeby
- start your browser and authenticate metamask to Rinkeby
- go to https://kmpblockchain.herokuapp.com/
- Play with it!
- _tip1: when using the dApp open browser's developer console and wait until you see a confirmation log in the console (or metamask confirmation) before pressing another button._
- _tip2: this is a testing dApp so don't expect any form validation. All form fields are required, if you submit a call without any of the params then expect an error and reload the page._

## Run Locally
### Setup
  - download project source code.
  - go to /final-project-Juan-cc/kmp and run: **npm install**
  - go to /final-project-Juan-cc/kmp/client and run: **npm install**
  - _tip1: if you have a symbolic link called "contracts" inside /final-project-Juan-cc/kmp/build/contracts, then please delete that link to avoid the error described below (*1)_  
  - _tip2: if you cant find the contracts folder then run: **npm run link-contracts** in /final-project-Juan-cc/kmp/client folder.
  - start ganache on port 8545
### Unit Testing
  - on /final-project-Juan-cc/kmp run: **truffle compile --all**  
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
*  CompanyFactory: 0x2371a23d23010A157521ff56dc9Eb07b0EdCd9df
*  CompanyUtil: 0x5C28ee9463c5B6D0a581FF1a3D60a4AD7f30e147
*  Migrations: 0xD4468AEd578609CfD6544b37244E3bDc8791C59f
*  Owned: 0xaEb8586Be2ED581d84BD48f34d6331B1a8dd7930
*  Platform: 0x22b3F292eF0675f8e497a16902DDC955C02A3E9d
*  Token: 0x0aCbb9c6c86161e8cC5b327582Ee6f8f7e63CA17
*  TokenFactory: 0xD288d0a489f0B79E189E145c5eD9d2f037B3C7cc
*  TokenUtil: 0x5e63A0C24994e758046C224F4D7038668CCd5e96




### Code Coverage useful link to fix parser
- https://github.com/sc-forks/solidity-parser/pull/18 (solidity-coverage)

### Symbolic link error (*1)
  fs.js:675
    return binding.read(fd, buffer, offset, length, position);
                   ^
  Error: EISDIR: illegal operation on a directory, read

