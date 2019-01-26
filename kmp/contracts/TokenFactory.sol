pragma solidity ^0.5.0;

import "./Company.sol";
import "./Token.sol";
import "./CompanyFactory.sol";
import "./CompanyUtil.sol";
import "./TokenUtil.sol";

/** @author Juan Castellon
    @title Library to create tokens on the platform
    @dev TokenFactory is a factory pattern implemented via a Library, that 
        will be used to create new tokens. It will basically conglomerate all
        the logic related to tokens creation and it's business rules. 
        At the moment creates instances for every request without any 
        validation, but the plan is to add all business rules here to create 
        tokens. 
 */
library TokenFactory {
    /** Constants */
    uint8 public constant MAX_OWNER_COMPANIES = 3; // 1 owner could register up to 3 companies.
    uint8 public constant MAX_COMPANY_TOKENS = 5; // 1 company could register up to 10 tokens.
    address internal constant EMPTY_ADDRESS = address(0);

    /** Modifiers */
    /** @dev Verify caller is company owner */
    modifier onlyCompanyOwner(address companyOwner) {
        require(
            msg.sender == companyOwner,
            "Only company owner can execute this function"
        );
        _;
    }

    /** Functions */
    /** @dev This function will create a token on the Platform. It will first
            validate that who is trying to create this token is the owner of the
            company. If it is the owner, then it will search for a position 
            available in the tokens array. If an available position is found, 
            then it will create a new Token instance and add it to the tokens
            array of that company.
        @param self This function will receive the object (where the data is 
                stored) they are called on as their first parameter.
        @param aCompany address of the company that wants to create this token.
        @param aName string with the name of the token.
        @param aSymbol string with a 3 chars (aprox) token symbol.
        @param initialAmount uint256 with initial supply for this token.
        @return the token recently created. 
     */
    function createTokenForCompany(
        CompanyFactory.Data storage self,
        address aCompany,
        string calldata aName,
        string calldata aSymbol,
        uint256 initialAmount
    ) 
        external 
        onlyCompanyOwner(CompanyUtil.findCompanyOwner(self, aCompany))
        returns (Token) 
    {
        uint8 nextPosition = TokenUtil.nextTokenAvailablePosition(
            self,
            address(aCompany)
        );
        require(
            MAX_COMPANY_TOKENS > nextPosition,
            "You can't create a new token. Max limit reached (5 tokens)"
        );
        Token newToken = new Token(
            aCompany,
            msg.sender,
            aName,
            aSymbol,
            initialAmount
        );
        self.tokens[aCompany][nextPosition] = address(newToken);
        return newToken;
    }

}
