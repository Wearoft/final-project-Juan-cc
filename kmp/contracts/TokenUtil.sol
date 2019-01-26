pragma solidity ^0.5.0;

import "./Token.sol";
import "./CompanyFactory.sol";
import "./CompanyUtil.sol";

/** @author Juan Castellon
    @title Library to create companies on the platform
    @dev CompanyFactory is a factory pattern implemented via a Library, that 
        will be used to create new companies. It will basically conglomerate all
        the logic related to companies creation and it's business rules. 
        At the moment creates instances for every request without any 
        validation, but the plan is to add all business rules here to create 
        companies. 
 */
library TokenUtil {
    /** Constants */
    uint8 public constant MAX_OWNER_COMPANIES = 3; // 1 owner could register up to 3 companies.
    uint8 public constant MAX_COMPANY_TOKENS = 5; // 1 company could register up to 5 tokens.
    address public constant EMPTY_ADDRESS = address(0);

    /** @dev Verify caller is company owner */
    modifier onlyCompanyOwner(address companyOwner) {
        require(
            msg.sender == companyOwner,
            "Only company owner can execute this function"
        );
        _;
    }

    /** @dev First it validates that only the company owner is who is calling
        this function. If it is the owner then it looks for the next 
        available position in the tokens array for this specific company and
        returns that position.
    @param self This function will receive the object (where the data is 
            stored) they are called on as their first parameter.
    @param aCompany company address to search for available positions in 
            the tokens array.
    @return next available position in the tokens array or MAX_COMPANY_TOKENS
            if no position available.
     */
    function nextTokenAvailablePosition(
        CompanyFactory.Data storage self,
        address aCompany
    ) 
        internal 
        view 
        onlyCompanyOwner(CompanyUtil.findCompanyOwner(self, aCompany))
        returns (uint8) 
    {
        address[MAX_COMPANY_TOKENS] memory companyTokens = self.tokens[aCompany];
        for (uint8 i = 0; i < MAX_COMPANY_TOKENS; i++) {
            if (companyTokens[i] == EMPTY_ADDRESS) {
                return i; // first position available.
            }
        }
        return MAX_COMPANY_TOKENS; // No empty spot available.
    }


    /** @dev find a token into the tokens array corresponding to that company.
        @param aCompany address of a company
        @param aToken address of a token
        @return true if found, false if not found.
     */
    function tokenInCompany(CompanyFactory.Data storage self, address aCompany, address aToken)
        public
        view
        onlyCompanyOwner(CompanyUtil.findCompanyOwner(self, aCompany))
        returns (bool)
    {
        address[MAX_COMPANY_TOKENS] memory companyTokens = self.tokens[aCompany];
        for (uint8 i = 0; i < MAX_COMPANY_TOKENS; i++) {
            if (companyTokens[i] == aToken) {
                return true; // Token found.
            }
        }
        return false; // Token not found.
    }

    /** @dev Look for a token inside a company list of tokens.
        @param aCompany company address to search
        @param aToken token address to search
        @return token address if found, 0x if not found. 
     */
    function findCompanyToken(CompanyFactory.Data storage self, address aCompany, address aToken)
        public
        view
        returns (address)
    {
        if (tokenInCompany(self, aCompany, aToken)) {
            return aToken;
        }
        return EMPTY_ADDRESS;
    }


}
