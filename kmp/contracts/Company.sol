
pragma solidity ^0.5.0;

import "./Owned.sol";

/** @author Juan Castellon
    @title Entity contract for a company. 
    @dev Every time the user creates a new company a new instance of 
        this Company contract is going to be created. It will store
        all data related with the company.
*/
contract Company is Owned {

    /** State variables */
    mapping(address => bool) public admins;
    string public name;
    string public phone;
    string public url;
    string private did;
    address private uPortAddress;
    mapping(address => address[]) public tokens;

    /** Events */
    /**
        @dev CompanyTerminated event is emitted every time a company is deleted.
        @param companyAddress address of the company we are about to delete.
        @param companyName string with the name of the company.
        @param phone string with phone number of the company.
        @param url string with url of the company.
     */
    event CompanyTerminated(
        address indexed companyAddress,
        string companyName,
        string phone,
        string url
    );

    /** @dev Default constructor where the owner and all attributes
            of a company are set.
        @param anOwner the address of this company's owner.
        @param companyName string with the name of the company.
        @param companyUrl string with company's url.
        @param companyDid string with company's DID (not used at the moment)
        @param uPortAdd address with uPort Ethr address (not used for now)
     */
    constructor(
        address anOwner,
        string memory companyName,
        string memory phoneNum,
        string memory companyUrl,
        string memory companyDid,
        address uPortAdd
    ) public {
        owner = anOwner;
        name = companyName;
        phone = phoneNum;
        url = companyUrl;
        did = companyDid;
        uPortAddress = uPortAdd;
        admins[owner] = true;
    }

    /** @dev this method will be executed to terminate a company. At the moment
            It's not fully implemented yet.        
     */
    function terminateCompany() external ownerOnly(msg.sender) {
        // TODO: before selfdestruction delegate token ownership to 
        // newCompanyContract.
        selfdestruct(msg.sender);
        emit CompanyTerminated(address(this), name, phone, url);
    }
}
