pragma solidity ^0.5.0;

import "./Token.sol";
import "./Owned.sol";
import "./Company.sol";
import "./CompanyFactory.sol";
import "./TokenFactory.sol";
import "./CompanyUtil.sol";
import "./TokenUtil.sol";


/**
    @author Juan Castellon
    @title Platform main contract to expose functionality to users.
    @dev Platform contract will allow  KMP Platform users to create 
        their own company and create their own tokens and persist
        the data in the Blockchain. 
 */
contract Platform is Owned {

    /** Libraries */
    /** @dev CompanyFactory library usage */
    using CompanyFactory for CompanyFactory.Data;
    /** @dev TokenFactory library usage */
    using TokenFactory for CompanyFactory.Data;
    /** @dev TokenUtil library usage */
    using TokenUtil for CompanyFactory.Data;
    /** @dev CompanyUtil library usage */
    using CompanyUtil for CompanyFactory.Data;

    /** Constants */
    uint8 public constant MAX_OWNER_COMPANIES = 3; // 1 owner could register up to 3 companies.
    uint8 public constant MAX_COMPANY_TOKENS = 5; // 1 company could register up to 5 tokens.
    address public constant EMPTY_ADDRESS = address(0);

    /** State variables */
    CompanyFactory.Data private platformData;
    bool internal stopped = false; // Circuit breaker

    /** Events */
    /** @dev 
            KMPCompanyCreated event emitted every time a company is 
            successfully created.
        @param company new company created address.
        @param name new company created name.
        @param owner new company owner.address
     */
    event KMPCompanyCreated(
        address company,
        string name,
        address indexed owner
    );
    
    /** @dev 
            KMPTokenCreated event emitted every time a token is 
            successfully created.
        @param company token company address.
        @param token new token created address.
        @param name token name
        @param symbol 3 chars token symbol
        @param initialAmount token total supply.
     */
    event KMPTokenCreated(
        address indexed company,
        address indexed token,
        string name,
        string symbol,
        uint256 initialAmount
    );

    /** Modifiers */
    /** @dev Verify that circuit breaker is not active. */
    modifier stopInEmergency() {
        require(!stopped);
        _;
    }

    /** @dev Verify caller is company owner */
    modifier onlyCompanyOwner(address companyOwner) {
        require(
            msg.sender == companyOwner,
            "Only company owner can execute this function"
        );
        _;
    }

    /** Constructors */
    /** @dev Platform contract owner is set on this constructor. */
    constructor() public Owned() {}

    /** Functions */
    /** @dev This function lets users to create their company on the platform.
        @param companyName name we will give to this company.
        @param phone company's phone number.
        @param url company's url.
        @param did company uPort id (not used for now).
        @param uPortAddress company uport Ethr address (not used for now).
        @return the Company just created.
        @notice emits KMPCompanyCreated event
     */
    function createCompany(
        string calldata companyName,
        string calldata phone,
        string calldata url,
        string calldata did,
        address uPortAddress
    ) 
        external 
        stopInEmergency 
        returns (Company) 
    {
        Company newCompany = platformData.createCompany(
            companyName,
            phone,
            url,
            did,
            uPortAddress
        );
        emit KMPCompanyCreated(
            address(newCompany),
            newCompany.name(),
            newCompany.owner()
        );
        return newCompany;
    }

    /** @dev This function lets users to create a token on one of their
            companies.
        @param bcCompany address of the company that owns this token.
        @param name token's name.
        @param symbol token's 3 chars symbol.
        @param initialAmount token total supply.
        @return The instance of the token just created.
        @notice emits KMPTokenCreated event
     */
    function createTokenForCompany(
        address bcCompany,
        string calldata name,
        string calldata symbol,
        uint256 initialAmount
    )
        external
        stopInEmergency
        onlyCompanyOwner(platformData.findCompanyOwner(bcCompany))
        returns (Token)
    {
        Token newToken = platformData.createTokenForCompany(
            bcCompany,
            name,
            symbol,
            initialAmount
        );
        emit KMPTokenCreated(
            bcCompany,
            address(newToken),
            name,
            symbol,
            initialAmount
        );
        return newToken;
    }

    /** @dev Retrieves the balance of a user for an specific token on a company.
        @param company the address of the company.
        @param token the address of the token.
        @param user the address of the user that owns this token.
        @return uint256 with user's token balance. 
     */
    function getUserTokenBalance(
        address company,
        address token,
        address user
    )
        external
        view
        onlyCompanyOwner(platformData.findCompanyOwner(company))
        returns (uint256 aBalance)
    {
        require(
            EMPTY_ADDRESS != platformData.findCompanyToken(company, token),
            "Token not found."
        );
        bytes memory payload = abi.encodeWithSignature(
            "balanceOf(address)",
            user
        );
        (bool result, bytes memory returnData) = token.staticcall(payload);
        if (result) {
            aBalance = abi.decode(returnData, (uint256));
        }
        return aBalance;
    }

    /** @dev This is a util function to expose functionality of the CompanyUtil
            Library. It looks for the company on the companies array for this 
            specific owner. If the company is found for this msg.sender then we
            return the owner, in case the company is not found in the companies
            array 0x is returned.
        @param aCompany company address to search for owner.
        @return the owner's address or 0x if not found.
     */
    function findCompanyOwnerUtil(address aCompany) 
        external
        view
        returns (address)
    {
        return platformData.findCompanyOwner(aCompany);
    }

    /** @dev This is a util function to expose functionality of the TokenUtil
            Library. Look for a token inside a company list of tokens.
        @param aCompany company address to search
        @param aToken token address to search
        @return token address if found, 0x if not found. 
     */
    function findCompanyTokenUtil(address aCompany, address aToken) 
        external
        view
        returns (address)
    {
        return platformData.findCompanyToken(aCompany, aToken);
    }

    /** @dev Circuit breaker switch to pause this contract state changes or
            resume.
     */
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
