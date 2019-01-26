pragma solidity ^0.5.0;

import "./Token.sol";
import "./Owned.sol";
import "./Company.sol";
import "./CompanyFactory.sol";
import "./TokenFactory.sol";

contract Platform is Owned {
    using CompanyFactory for CompanyFactory.Data;
    using TokenFactory for CompanyFactory.Data;

    CompanyFactory.Data private companyFactory;

    uint8 public constant MAX_OWNER_COMPANIES = 3; // 1 owner could register up to 3 companies.
    uint8 public constant MAX_COMPANY_TOKENS = 5; // 1 company could register up to 5 tokens.
    address public constant EMPTY_ADDRESS = address(0);

    bool internal stopped = false; // Circuit breaker

    // Events
    event KMPCompanyCreated(
        address company,
        string name,
        address indexed owner
    );
    event KMPTokenCreated(
        address indexed _company,
        address indexed _token,
        string _name,
        string _symbol,
        uint256 _initialAmount
    );

    constructor() public Owned() {}

    // Circuit breaker modifier
    modifier stopInEmergency() {
        require(!stopped);
        _;
    }

    modifier onlyCompanyOwner(address companyOwner) {
        require(
            msg.sender == companyOwner,
            "Only company owner can execute this function"
        );
        _;
    }

    function createCompany(
        string calldata _companyName,
        string calldata _phone,
        string calldata _url,
        string calldata _did,
        address _uPortAddress
    ) external stopInEmergency returns (Company) {
        Company newCompany = companyFactory.createCompany(
            _companyName,
            _phone,
            _url,
            _did,
            _uPortAddress
        );
        emit KMPCompanyCreated(
            address(newCompany),
            newCompany.name(),
            newCompany.owner()
        );
        return newCompany;
    }

    function createTokenForCompany(
        address _bcCompany,
        string calldata _name,
        string calldata _symbol,
        uint256 _initialAmount
    )
        external
        stopInEmergency
        onlyCompanyOwner(findCompanyOwner(_bcCompany))
        returns (Token)
    {
        Token newToken = companyFactory.createTokenForCompany(
            _bcCompany,
            _name,
            _symbol,
            _initialAmount
        );
        emit KMPTokenCreated(
            _bcCompany,
            address(newToken),
            _name,
            _symbol,
            _initialAmount
        );
        return newToken;
    }

    function getUserTokenBalance(
        address _company,
        address _token,
        address _user
    )
        external
        view
        onlyCompanyOwner(findCompanyOwner(_company))
        returns (uint256 aBalance)
    {
        require(
            EMPTY_ADDRESS != findCompanyToken(_company, _token),
            "Token not found."
        );
        bytes memory payload = abi.encodeWithSignature(
            "balanceOf(address)",
            _user
        );
        (bool result, bytes memory returnData) = _token.staticcall(payload);
        if (result) {
            aBalance = abi.decode(returnData, (uint256));
        }
        return aBalance;
    }

    function findCompanyOwnerUtil(address company) external view returns (address) {
        // Util methods are for development purposes only.
        return findCompanyOwner(company);
    }

    function findCompanyOwner(address aCompany) internal view returns (address) {
        address[MAX_OWNER_COMPANIES] memory ownerCompanies = companyFactory.companies[msg.sender];
        for (uint8 i = 0; i < MAX_OWNER_COMPANIES; i++) {
            if (ownerCompanies[i] == aCompany) {
                return Company(ownerCompanies[i]).owner();
            }
        }
        return EMPTY_ADDRESS;
    }

    function tokenInCompany(address aCompany, address aToken)
        public
        view
        returns (bool)
    {
        require(
            msg.sender == findCompanyOwner(aCompany),
            "Only company owner can search for tokens."
        );
        address[MAX_COMPANY_TOKENS] memory companyTokens = companyFactory.tokens[aCompany];
        for (uint8 i = 0; i < MAX_COMPANY_TOKENS; i++) {
            if (companyTokens[i] == aToken) {
                return true; // Token found.
            }
        }
        return false; // Token not found.
    }

    function findCompanyToken(address aCompany, address aToken)
        public
        view
        returns (address)
    {
        if (tokenInCompany(aCompany, aToken)) {
            return aToken;
        }
        return EMPTY_ADDRESS;
    }

    function activateEmergency()
        external
        ownerOnly(msg.sender)
        returns (bool)
    {
        if (stopped == false) {
            stopped = true;
        } else {
            stopped = false;
        }
        return stopped;
    }
}
