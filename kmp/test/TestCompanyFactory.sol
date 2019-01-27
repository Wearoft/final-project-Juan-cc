pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/CompanyFactory.sol";
import "../contracts/Platform.sol";

contract TestCompanyFactory {
    // setting CompanyFactory library to use over Data/data
    using CompanyFactory for CompanyFactory.Data;
    CompanyFactory.Data private data;

    // Global variables
    Platform private kmp;

    // Global constants
    address constant SOME_ADDRESS = 0xdA35deE8EDDeAA556e4c26268463e26FB91ff74f;

    function beforeAll() public {
        // we set this platform instance to access its constants 
        kmp = Platform(DeployedAddresses.Platform());
    }

    function testNextCompanyAvailablePositionEmpty() public {
        // we call the function to obtain the first available position
        uint256 position = data.nextCompanyAvailablePosition();
        // we check the first position available in the array is 0 as there
        // are no companies created yet.
        Assert.isZero(
            position,
            "The first position available should be Zero."
        );
    }

    function testCreateCompany() public {
        string memory companyName = "Some  Name";
        // creating a company
        Company newBc = data.createCompany(
            companyName,
            "123456789",
            "www.google.com",
            "did:eth:0x2f3fcf4c3",
            SOME_ADDRESS
        );
        // validating company got created successfully
        Assert.equal(newBc.name(), companyName, "Company name is incorrect.");
        // getting next available position in the companies array
        uint256 position = data.nextCompanyAvailablePosition();
        // now we check position is 1 as 1 company was already created at position 0
        Assert.equal(position, 1, "The first position available should be 1.");
    }

    function testNextCompanyAvailablePosition1() public {
        // creating specific test to validate the companies array next available 
        // position is still position 1
        uint256 position = data.nextCompanyAvailablePosition();
        // validating position 1
        Assert.equal(position, 1, "We should be in position 1.");
    }

    function testCompleteCompanyArray() public {
        // creating a loop to create several companies and complete the 
        // companies array. This test will automatically add more companies if 
        // the size of the array is increased, that's why we are using the 
        // platform constant kmp.MAX_OWNER_COMPANIES()
        for (uint8 i = 0; i < kmp.MAX_OWNER_COMPANIES() - 1; i++) {
            data.createCompany(
                "Some  Name",
                string(abi.encode(i)),
                "www.google.com",
                "did:eth:0x2f3fcf4c3",
                SOME_ADDRESS
            );
        }
    }

    function testNextCompanyAvailablePositionMAX() public {
        // getting next available position knowing we reached the limit.
        uint256 position = data.nextCompanyAvailablePosition();
        // validating MAX_OWNER_COMPANIES has been reached. 
        Assert.equal(
            position,
            kmp.MAX_OWNER_COMPANIES(),
            "We should have reached MAX LIMIT (MAX_OWNER_COMPANIES)."
        );
    }

}
