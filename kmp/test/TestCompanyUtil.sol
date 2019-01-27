pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/CompanyFactory.sol";
import "../contracts/CompanyUtil.sol";
import "../contracts/Platform.sol";

contract TestCompanyUtil {
    // setting CompanyFactory library to use over Data/data
    using CompanyFactory for CompanyFactory.Data;
    // also setting CompanyUtil library to use over Data/data. YES! we will use
    // 2 libraries over the same data struct :o
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
        // creating the company we will use along the test suite
        bc = data.createCompany(
            "Global Company Name",
            "123456789",
            "www.google.com",
            "did:eth:0x2f3fcf4c3",
            SOME_ADDRESS
        );
    }

    
    function testFindCompanyOwner() public {
        // searching the owner of the company just created
        address owner = data.findCompanyOwner(address(bc));
        // validating the owner who created the company and the one we found 
        // are the same. In this case, the company creator = owner is this 
        // test contract.
        Assert.equal(owner, bc.owner(), "Company owner found not correct.");
    }

    function testFindCompanyOwnerCompanyNotFound() public {
        // searching owner on inexistent company
        address owner = data.findCompanyOwner(address(SOME_ADDRESS));
        // validating no owner was found
        Assert.equal(owner, address(0), "We found an owner and we shouldn't.");
    }

}
