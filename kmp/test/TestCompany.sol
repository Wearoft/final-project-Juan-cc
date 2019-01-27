pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Company.sol";

contract TestCompany {
    // Global variables
    Company bc;

    // Global constants
    address constant SOME_ADDRESS = 0xdA35deE8EDDeAA556e4c26268463e26FB91ff74f;
    address constant FAKE_OWNER = 0xD6aE8250b8348C94847280928c79fb3b63cA453e;

    
    function testCreateCompany() public {
        string memory companyName = "Bus Company Name";
        // creating new company
        bc = new Company(
            address(this),
            companyName,
            "123456789",
            "www.google.com",
            "did:eth:0x2f3fcf4c3",
            SOME_ADDRESS
        );
        // validating company name is the one we previously set
        Assert.equal(companyName, bc.name(), "Company not created");
    }

    function testModifyCompanyOwner() public {
        // here we create the company 
        bc = new Company(  
            address(this),
            "Bus Company Name",
            "123456789",
            "www.google.com",
            "did:eth:0x2f3fcf4c3",
            SOME_ADDRESS
        );
        // trying to modify owner
        bc.modifyOwner(FAKE_OWNER);
        // validating owner was changed successfuly
        Assert.equal(
            bc.owner(),
            FAKE_OWNER,
            "Owner should be able to terminate company"
        );
    }

    function testModifyCompanyOwnerException() public {
        // creating new company
        bc = new Company(
            FAKE_OWNER,
            "Bus Company Name",
            "123456789",
            "www.google.com",
            "did:eth:0x2f3fcf4c3",
            SOME_ADDRESS
        );
        // trying to modify owner but it will fail as is not the owner who is 
        // calling this function.
        // preparing the messsage to use low level call to encapsulate exception.
        bytes memory payload = abi.encodeWithSignature(
            "modifyOwner(address)",
            address(this)
        );
        // calling function
        (bool result, ) = address(bc).call(payload);
        // validating result is false, as it should throw exception due to incorrect
        // owner and should return false.
        Assert.isFalse(result, "Only the owner can terminate a company");
    }

    function testTerminateCompanyWithException() public {
        // creating company
        bc = new Company(
            FAKE_OWNER,
            "Bus Company Name",
            "123456789",
            "www.google.com",
            "did:eth:0x2f3fcf4c3",
            SOME_ADDRESS
        );
        // trying to call terminateCompany() from an account that is not the
        // owner. It should fail and return false.
        // preparing message call
        bytes memory payload = abi.encodeWithSignature("terminateCompany()");
        // calling function
        (bool result, ) = address(bc).call(payload);
        // validating result is false due to incorrect owner
        Assert.isFalse(result, "Only owner can terminate company");
    }

    function testTerminateCompany() public {
        // creating company
        bc = new Company(
            address(this),
            "Bus Company Name",
            "123456789",
            "www.google.com",
            "did:eth:0x2f3fcf4c3",
            SOME_ADDRESS
        );
        // calling terminate company
        bc.terminateCompany();
        // we should get no exception. TODO: find a way to do this 
        // web3.eth.getCode(yourContractAddress) in solidity to validate the 
        // company code got removed.
        
    }
}
