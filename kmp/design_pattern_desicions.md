********************************************
Design Patterns and Best Practices Desicions 
********************************************


Factory
=======
I built 2 factories. 1 factory to create Companies (CompanyFactory.sol) and 1 
other factory to create Tokens (TokenFactory.sol). At the moment both factories
are simple and they only create contracts, but the idea is to add the business 
logic/rules related to Companies or Tokens creation in those factories to 
simplify the main contract (Platform.sol).


Utilities
=========
Functionality related with the manipulation of Companies or Tokens will be found
on each or their respectives Utils (CompanyUtil and TokenUtil). By implementing 
this pattern we are reducing duplicate code and error occurrences. On the other
hand, this operations will cost more than a local contract function implementation. 


DelegateCall (not a Pattern)
============
I want this platform to be open decentralized and disintermediated, so I am 
using delegatecalls to enable users create their own Company and Token. This 
way both contract Company and Tokens will be owned by the user not by the platform.


Security
========
The circuit breaker pattern allows the owner to disable or enable a contract by
a runtime toggle.


