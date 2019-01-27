pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Token.sol";

contract TestToken {
    address constant COMPANY = 0x6635F83421Bf059cd8111f180f0727128685BaE4;
    address owner;
    string constant NAME = "Token Name";
    string constant SYMBOL = "TKN";
    uint256 constant INITIAL_SUPPLY = 1000;
    uint256 constant EMPTY_BALANCE = 0;
    uint256 constant AMOUNT_TO_TRANSFER = 100;
    address constant FAKE_ADDRESS = 0x82bB943fda5dB43f6622464f26808EDdf40Bb9fE;
    Token token;

    function beforeAll() public{
       // setting owner as this contract address
        owner = address(this);
    }

    function beforeEach() public {
         // creating new token
        token = new Token(
            COMPANY,
            owner,
            NAME,
            SYMBOL,
            INITIAL_SUPPLY
        );
    }

    function testConstructor() public {
        // validating the newly created token has the right supply
        Assert.equal(
            token.totalSupply(),
            INITIAL_SUPPLY,
            "Incorrect total supply"
        );
    }

    function testBalanceOf() public {
        // validating token owner balance is total supply as no transfer happened yet
        Assert.equal(
            token.balanceOf(owner),
            token.totalSupply(),
            "Owner should own all newly created tokens"
        );
        // validating any other account balance is 0
        Assert.equal(
            token.balanceOf(FAKE_ADDRESS),
            EMPTY_BALANCE,
            "Incorrect balance of FAKE_ADDRESS"
        );
    }

    function testTransfer() public {
        // validating the balance of a fake account is 0
        Assert.equal(
            token.balanceOf(FAKE_ADDRESS),
            EMPTY_BALANCE,
            "Balance of FAKE_ADDRESS should be 0"
        );
        // then we transfer some tokens to that account
        token.transfer(FAKE_ADDRESS, AMOUNT_TO_TRANSFER);
        // we validate the new balance after the transfer on the fake account
        Assert.equal(
            token.balanceOf(FAKE_ADDRESS),
            AMOUNT_TO_TRANSFER,
            "New FAKE_ADDRESS balance should be AMOUNT_TO_TRANSFER"
        );
        // we validate the new balance after the transfer on the owners account
        Assert.equal(
            token.balanceOf(owner),
            (INITIAL_SUPPLY - AMOUNT_TO_TRANSFER),
            "New FAKE_ADDRESS balance should be AMOUNT_TO_TRANSFER"
        );
    }

    function testTransferFromAnotherAddressException() public {
        // creating a token assigned to a different owner
        Token newToken = new Token(
            COMPANY,
            FAKE_ADDRESS,
            NAME,
            SYMBOL,
            INITIAL_SUPPLY
        );
        // trying to transfer tokens using a different account
        bytes memory payload = abi.encodeWithSignature(
            "transfer(address,uint256)",
            owner,
            INITIAL_SUPPLY + 1
        );
        // it should throw so we expect false in result 
        (bool result, ) = address(newToken).call(payload);
        // validating result is false due to the exception thrown
        Assert.isFalse(
            result,
            "I should get an error transferring from another account."
        );
    }

    function testExceedTransferAmount() public {
        // trying to transfer more than total supply
        bytes memory payload = abi.encodeWithSignature(
            "transfer(address,uint256)",
            FAKE_ADDRESS,
            INITIAL_SUPPLY + 1
        );
        // we should get an exception trying to transfer that amount
        (bool result, ) = address(token).call(payload);
        // validating result is false due to the exception thrown
        Assert.isFalse(
            result,
            "I should get an error transferring more than my balance"
        );
    }
}
