pragma solidity ^0.5.0;

/** @author Juan Castellon
    @title Owned contract will provide functionality to validate ownership.
    @dev This contract will be used to set the owner of a contract and to 
        validate that only the owner can execute certain action on the Platform.
        This was created before I realize there was an audited Ownable contract 
        from OpenZeppelin so I may use their implementation in the future. 
 */
contract Owned {
    /** State variables */
    address public owner;

    /** Modifiers */
    /** @dev This modifier validates that only the owner of the contract can
            proceed executing this action on the calling contract. 
        @param anOwner address to validate against the state variable owner. If
            is the owner then can proceed, if it is not the owner then throws
            an error. 
     */
    modifier ownerOnly(address anOwner) {
        require(owner == anOwner, "Access denied. Company owner only.");
        _;
    }

    /** Constructors */
    /** @dev Default constructor that will be used to set the owner of the
            contract.
     */
    constructor() public {
        owner = msg.sender;
    }

    /** Functions */
    /** @dev This function will allow the owner of the contract to transfer 
            ownership to a new owner.
        @param anOwner new owner's address.
    */
    function modifyOwner(address anOwner) public ownerOnly(msg.sender) {
        owner = anOwner;
    }

}
