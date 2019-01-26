pragma solidity ^0.5.0;

import "../client/node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "../client/node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";
import "./Owned.sol";

contract Token is Owned, ERC20, ERC20Detailed {
    uint8 private constant NO_DECIMALS = 0;
    address private tokenFactory;
    address private company;

    constructor(
        address _company,
        address _owner,
        string memory tokenName,
        string memory tokenSymbol,
        uint256 initialSupply
    ) 
        public 
        ERC20Detailed(tokenName, tokenSymbol, NO_DECIMALS)
        ERC20()
        Owned()
    {
        owner = _owner; // TODO: refactor create from factory, but then transfer ownership
        tokenFactory = msg.sender;
        company = _company;
        _mint(_owner, initialSupply);
    }

}
