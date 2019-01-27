***************************
Avoiding Common Attacks
***************************

Owner validation
================
To prevent external users to modify the state of the contracts without permission.
The majority of the contracts inherit from Owned.sol. Most of the functions 
(even some that only read storage state) use ownerOnly() modifier to validate 
that only allowed users can interact with the contract.  


Gas Limit DoS
=============
To avoid having gas limit issues we took into account the following considerations:
* Arrays are limited to a fixed size: 
  uint8 constant public MAX_OWNER_COMPANIES = 3; // 1 owner could register up to 5 companies.
  uint8 constant public MAX_COMPANY_TOKENS = 5; // 1 company could register up to 10 tokens.
* Instead of iterating through arrays I am using mappings to access directly to the value.
  mapping (address => address[MAX_OWNER_COMPANIES]) internal companies; // (owner => companies[5]) 
  mapping (address => address[MAX_COMPANY_TOKENS]) internal tokens; // (company => token[]))


Circuit Breaker
===============
In case I find the platform is being unethically used or I find a bug that 
requires a new contract update, there is a circuit breaker implemented that can 
be enabled by calling activateEmergency() from the Platform owner account. This 
way the functions that can modify state on the platform will stop working.


Reentrancy
===========
An specific point of reentrancy to control in this dApp is when users try to 
transfer tokens. The system is safe from reentrance attack since ether send is 
at the end, plus it uses .send() rather than .call.value().

