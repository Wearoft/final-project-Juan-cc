pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/CompanyFactory.sol";
import "../contracts/CompanyUtil.sol";
import "../contracts/Platform.sol";

contract TestCompanyUtil {
    using CompanyFactory for CompanyFactory.Data;
    using CompanyUtil for CompanyFactory.Data;
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
        
    }

    
    function testFindCompanyOwner() public {
        address owner = data.findCompanyOwner(address(bc));
        Assert.equal(owner, bc.owner(), "Company owner found not correct.");
    }

    function testFindCompanyOwnerNotFound() public {
        address owner = data.findCompanyOwner(address(SOME_ADDRESS));
        Assert.equal(owner, address(0), "We found an owner and we shouldn't.");
    }

}
