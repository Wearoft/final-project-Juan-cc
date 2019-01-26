pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/CompanyFactory.sol";
import "../contracts/Platform.sol";

contract TestCompanyFactory {
    using CompanyFactory for CompanyFactory.Data;
    CompanyFactory.Data private data;

    // Global variables
    Platform private kmp;

    // Global constants
    address constant SOME_ADDRESS = 0xdA35deE8EDDeAA556e4c26268463e26FB91ff74f;

    function beforeAll() public {
        kmp = Platform(DeployedAddresses.Platform());
    }

    function testNextCompanyAvailablePositionEmpty() public {
        uint256 position = data.nextCompanyAvailablePosition();
        Assert.isZero(
            position,
            "The first position available should be Zero."
        );
    }

    function testCreateCompany() public {
        string memory companyName = "Some  Name";
        Company newBc = data.createCompany(
            companyName,
            "123456789",
            "www.google.com",
            "did:eth:0x2f3fcf4c3",
            SOME_ADDRESS
        );
        Assert.equal(newBc.name(), companyName, "Company name is incorrect.");
        uint256 position = data.nextCompanyAvailablePosition();
        Assert.equal(position, 1, "The first position available should be 1.");
    }

    function testNextCompanyAvailablePosition1() public {
        uint256 position = data.nextCompanyAvailablePosition();
        Assert.equal(position, 1, "We should be in position 1.");

    }

    function testCompleteCompanyArray() public {
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
        uint256 position = data.nextCompanyAvailablePosition();
        Assert.equal(
            position,
            kmp.MAX_OWNER_COMPANIES(),
            "We should have reached MAX LIMIT (MAX_OWNER_COMPANIES)."
        );
    }

}
