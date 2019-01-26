pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/TokenUtil.sol";
import "../contracts/TokenFactory.sol";
import "../contracts/CompanyFactory.sol";
import "../contracts/Platform.sol";

contract TestTokenUtil {
    using TokenUtil for CompanyFactory.Data;
    using TokenFactory for CompanyFactory.Data;
    using CompanyFactory for CompanyFactory.Data;
    CompanyFactory.Data private data;

    // Global variables
    Platform private kmp;
    Company private bc;
    Token private token;

    // Global constants
    address constant SOME_ADDRESS = 0xdA35deE8EDDeAA556e4c26268463e26FB91ff74f;
    uint256 constant TOTAL_SUPPLY = 1000;

    function beforeAll() public {
        bc = data.createCompany(
            "Global Company Name",
            "123456789",
            "www.google.com",
            "did:eth:0x2f3fcf4c3",
            SOME_ADDRESS
        );
        token = data.createTokenForCompany(
            address(bc),
            "Tokenzito",
            "TKZT",
            TOTAL_SUPPLY
        );
    }

    function testTokenInCompany() public {
        bool result = data.tokenInCompany(address(bc), address(token));
        Assert.isTrue(result, "Token not found.");
        address nonExistentToken = 0xFC18Cbc391dE84dbd87dB83B20935D3e89F5dd91;
        result = data.tokenInCompany(address(bc), address(nonExistentToken));
        Assert.isFalse(result, "Non-Existent Token was found, but shouldn't.");
    }


}
