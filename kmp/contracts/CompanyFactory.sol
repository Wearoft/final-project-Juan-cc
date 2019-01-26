pragma solidity ^0.5.0;

import "./Company.sol";

/** @author Juan Castellon
    @title Library to create companies on the platform
    @dev CompanyFactory is a factory pattern implemented via a Library, that 
        will be used to create new companies. It will basically conglomerate all
        the logic related to companies creation and it's business rules. 
        At the moment creates instances for every request without any 
        validation, but the plan is to add all business rules here to create 
        companies. 
 */
library CompanyFactory {
    /** Constants */
    uint8 public constant MAX_OWNER_COMPANIES = 3; // 1 owner could register up to 3 companies.
    uint8 public constant MAX_COMPANY_TOKENS = 5; // 1 company could register up to 5 tokens.
    address public constant EMPTY_ADDRESS = address(0);

    /** Data structures */
    /** @dev This Data structure is used to define the persistence structure I 
            will use in the Platform contract.
            I decided to use arrays to be able to iterate through them. This may
            change for a mapping in the future.
     */
    struct Data {
        mapping(address => address[MAX_OWNER_COMPANIES]) companies; // (owner => companies[3])
        mapping(address => address[MAX_COMPANY_TOKENS]) tokens; // (company => token[5]))
    }

    /** Functions */
    /** @dev First we find the first position available in the companies array, 
            if there is at least one available position for this owner address 
            (max 3 per owner), we create the company, add it to the companies 
            array and return it. As this is a library we will inherit the 
            context of the contract that is calling it (Platform), this is due 
            to the nature of low level calls to libraries (delegatecall).
        @param self This function will receive the object (where the data is 
                stored) they are called on as their first parameter.
        @param aCompanyName string with the name to use for this company.
        @param aPhone string with the phone number for this company.
        @param aUrl string with the URL for this company.
        @param aDid string with company's uPort DID (not used yet).
        @param uPortAdd uPort Ethr address (not used yet).
        @return a new company instance.
     */
    function createCompany(
        Data storage self,
        string calldata aCompanyName,
        string calldata aPhone,
        string calldata aUrl,
        string calldata aDid,
        address uPortAdd
    ) 
        external 
        returns (Company) 
    {
        uint8 position = nextCompanyAvailablePosition(self);
        require(
            MAX_OWNER_COMPANIES > position,
            "You can't create a new company. Max limit reached (3 companies)"
        );
        Company newCompany = new Company(
            msg.sender,
            aCompanyName,
            aPhone,
            aUrl,
            aDid,
            uPortAdd
        );
        self.companies[msg.sender][position] = address(newCompany);
        return newCompany;
    }

    /** @dev Utility function to expose the functionality of 
            nextCompanyAvailablePosition() for testing purposes.
        @param self This function will receive the object (where the data is 
                stored) they are called on as their first parameter.
        @return next available position in the companies array.
     */
    function nextCompanyAvailablePositionUtil(Data storage self)
        external
        view
        returns (uint8)
    {
        return nextCompanyAvailablePosition(self);
    }

    /** @dev Looks for the next available position in the companies array and 
            returns that position.
        @param self This function will receive the object (where the data is 
                stored) they are called on as their first parameter.
        @return next available position in the companies array or MAX_OWNER_COMPANIES
                if no position available.
     */
    function nextCompanyAvailablePosition(Data storage self)
        internal
        view
        returns (uint8)
    {
        address[MAX_OWNER_COMPANIES] memory ownerCompanies = self.companies[msg.sender];
        for (uint8 i = 0; i < MAX_OWNER_COMPANIES; i++) {
            if (ownerCompanies[i] == EMPTY_ADDRESS) {
                return i; // first position available.
            }
        }
        return MAX_OWNER_COMPANIES; // No empty spot available.
    }

}
