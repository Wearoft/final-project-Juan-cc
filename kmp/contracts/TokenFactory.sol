pragma solidity ^0.5.0;

import "./Company.sol";
import "./Token.sol";
import "./CompanyFactory.sol";

library TokenFactory {
    // Constants
    uint8 public constant MAX_OWNER_COMPANIES = 3; // 1 owner could register up to 3 companies.
    uint8 public constant MAX_COMPANY_TOKENS = 5; // 1 company could register up to 10 tokens.
    address internal constant EMPTY_ADDRESS = address(0);


    function createTokenForCompany(
        CompanyFactory.Data storage self,
        address _bcCompany,
        string calldata _name,
        string calldata _symbol,
        uint256 _initialAmount
    ) external returns (Token) {
        require(msg.sender == findCompanyOwner(self, _bcCompany)); // 2nd time checking correct ownership.
        Token newToken = new Token(
            _bcCompany,
            msg.sender,
            _name,
            _symbol,
            _initialAmount
        );
        uint8 nextPosition = nextTokenAvailablePosition(
            self,
            address(_bcCompany)
        );
        self.tokens[_bcCompany][nextPosition] = address(newToken);
        return newToken;
    }

    function nextTokenAvailablePosition(
        CompanyFactory.Data storage self,
        address aCompany
    ) internal view returns (uint8) {
        require(
            msg.sender == findCompanyOwner(self, aCompany),
            "Only company owner can search for tokens."
        );
        address[MAX_COMPANY_TOKENS] memory companyTokens = self.tokens[aCompany];
        for (uint8 i = 0; i < MAX_COMPANY_TOKENS; i++) {
            if (companyTokens[i] == EMPTY_ADDRESS) {
                return i; // first position available.
            }
        }
        return MAX_COMPANY_TOKENS; // No empty spot available.
    }

    function findCompanyownerUtil(
        CompanyFactory.Data storage self,
        address aCompany
    ) external view returns (address) {
        return findCompanyOwner(self, aCompany);
    }

    function findCompanyOwner(CompanyFactory.Data storage self, address aCompany)
        internal
        view
        returns (address)
    {
        address[MAX_OWNER_COMPANIES] memory ownerCompanies = self.companies[msg.sender];
        for (uint8 i = 0; i < MAX_OWNER_COMPANIES; i++) {
            if (ownerCompanies[i] == aCompany) {
                return Company(ownerCompanies[i]).owner();
            }
        }
        return EMPTY_ADDRESS;
    }

}
