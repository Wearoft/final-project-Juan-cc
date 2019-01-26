pragma solidity ^0.5.0;

import "./Company.sol";
import "./CompanyFactory.sol";

/** @author Juan Castellon
    @title Library to create companies on the platform
    @dev CompanyFactory is a factory pattern implemented via a Library, that 
        will be used to create new companies. It will basically conglomerate all
        the logic related to companies creation and it's business rules. 
        At the moment creates instances for every request without any 
        validation, but the plan is to add all business rules here to create 
        companies. 
 */
library CompanyUtil {
    /** Constants */
    uint8 public constant MAX_OWNER_COMPANIES = 3; // 1 owner could register up to 3 companies.
    uint8 public constant MAX_COMPANY_TOKENS = 5; // 1 company could register up to 5 tokens.
    address public constant EMPTY_ADDRESS = address(0);



    /** @dev Look for the company on the companies array for this specific owner. 
        If the company is found for this msg.sender then we return the owner,
        in case the company is not found in the companies array 0x is returned.
    @param aCompany company address to search for owner.
    @return the owner's address or 0x if not found.
     */
    function findCompanyOwner(CompanyFactory.Data storage self, address aCompany) public view returns (address) {
        address[MAX_OWNER_COMPANIES] memory ownerCompanies = self.companies[msg.sender];
        for (uint8 i = 0; i < MAX_OWNER_COMPANIES; i++) {
            if (ownerCompanies[i] == aCompany) {
                return Company(ownerCompanies[i]).owner();
            }
        }
        return EMPTY_ADDRESS;
    }

}
