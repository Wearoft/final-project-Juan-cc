
pragma solidity ^0.5.0;

import "./Owned.sol";

/** @author Juan Castellon jcc.eth@gmail.com 
    @title 
*/
contract Company is Owned {
    /** Type declarations */

    /** State variables */
    mapping(address => bool) public admins;
    string public name;
    string public phone;
    string public url;
    string private did;
    address private uPortAddress;
    mapping(address => address[]) public tokens;

    /** Events */

    event CompanyCreated(
        address indexed companyAddress,
        string _companyName,
        string _phone,
        string _url
    );
    event CompanyTokenAdded(address indexed tokenAdded);
    event CompanyMsgSender(address indexed msgSender);
    event CompanyTerminated(
        address indexed companyAddress,
        string _companyName,
        string _phone,
        string _url
    );

    constructor(
        address _owner,
        string memory _companyName,
        string memory _phone,
        string memory _url,
        string memory _did,
        address _uPortAddress
    ) public {
        owner = _owner;
        name = _companyName;
        phone = _phone;
        url = _url;
        did = _did;
        uPortAddress = _uPortAddress;
        admins[owner] = true;

    }

    function terminateCompany() external ownerOnly(msg.sender) {
        // TODO: before selfdestruction delegate token ownership to newCompanyContract.
        selfdestruct(msg.sender);
        emit CompanyTerminated(address(this), name, phone, url);
    }
}
