pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Owned.sol";

contract TestOwned {
    // Global variables
    Owned newOwnedInstance;
    Owned deployedOwned;

    // Global constants
    address constant SOME_ADDRESS = 0xdA35deE8EDDeAA556e4c26268463e26FB91ff74f;

    function beforeAll() public {
        // setting Owned instance deployed in migrations. Owner will be accounts[0]
        deployedOwned = Owned(DeployedAddresses.Owned());
        // creating new Owned instance. Owner will be this contract.
        newOwnedInstance = new Owned();
    }

    function testChangeOwnership() public {
        // transferring ownership to new owner
        newOwnedInstance.modifyOwner(SOME_ADDRESS);
        // validating new owner is correct
        Assert.equal(
            address(newOwnedInstance.owner()),
            SOME_ADDRESS,
            "Owner modification failed."
        );
    }

    function testChangeOwnershipException() public {
        // trying to transfer ownership without being previous owner
        bytes memory payload = abi.encodeWithSignature(
            "modifyOwner(address)",
            SOME_ADDRESS
        );
        // executing a low level call as is expected to throw
        (bool result, ) = address(deployedOwned).call(payload);
        // validating we receive false due to throw because only the owner can
        // transfer ownership and the owner of the deployedOwner is accounts[0],
        // no this contract.
        Assert.isFalse(result, "Owner modification should fail.");
    }

}
