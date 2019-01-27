var Platform = artifacts.require("./Platform.sol");

contract('Platform', function(accounts) {
  
  let platformInstance;
  
  before('setup contract for each test', async function () {
    // getting platform instance from migrations
    platformInstance = await Platform.deployed();
  });

  it("...validating circuit breaker initial status.", async() => {
      // executing a call to validate circuit breaker state variable status 
      // after activating emergency switch
      let isActive = await platformInstance.activateEmergency.call({from: accounts[0]});
      // validating the switch would return true.
      assert.isTrue(isActive, "Circuit breaker activation failed.");
  });

  it("...should activate and deactivate circuit breaker.", async() => {
    // getting circuit breaker state variable after call. Keep in mind we are not
    // changing the state, is just a .call
    let isActive = await platformInstance.activateEmergency.call({from: accounts[0]});
    // again validating circuit breaker state variable before changing it.
    assert.isTrue(isActive, "Circuit breaker should be true after call.");
    // now yes, we activate the switch and change state variable. Check that we
    // are not using .call this time but calling the function directly.
    await platformInstance.activateEmergency({from: accounts[0]}); // Updating state
    // getting circuit breaker state variable again
    isActive = await platformInstance.activateEmergency.call({from: accounts[0]});
    // validating circuit breaker is activated
    assert.isFalse(isActive, "Circuit breaker deactivation failed.");
  });

  it("...only account[0] should manipulate circuit breaker.", async() => {
    try {
      // trying to activate circuit breaker from account that is not owner
      await platformInstance.activateEmergency({from: accounts[1]});
    } catch (e){
      // exception is expected so we return true
      return true;
    }
    // if we reached this point, we never got the exception so we are not validating
    // ownership correctly
    throw new Error("I should never see this as I expect an error!")
  });
 
  it("...trying to createCompany when circuit breaker is active.", async() => {
    // getting circuit breaker status
    let isStopped = await platformInstance.activateEmergency.call({from: accounts[0]});
    // validating circuit breaker is active
    assert.isFalse(isStopped, "Circuit breaker was not active, but it should.");
    try {
      // trying to create a company when circuit breaker is active should fail
      await platformInstance.createCompany( 
        "companyName",
        "123456789",
        "www.google.com",
        "did:eth:0x2f3fcf4c3",
        "0xdA35deE8EDDeAA556e4c26268463e26FB91ff74f"
      );
    } catch (e) {
      // exception is expected so we return true
      return true;
    }
    // if we reached this point, we never got the exception so we are not validating
    // ownership correctly
    throw new Error("I should never see this as I expect an error!")

  });

  it("...trying to getUserTokenBalance from account different from company owner.", async() => {
    try {
      // trying to get balance
      await platformInstance.getUserTokenBalance.call({from: accounts[0]});
    } catch (e) {
      // exception is expected so we return true
      return true;
    }
    // if we reached this point, we never got the exception so we are not validating
    // ownership correctly
    throw new Error("I should never see this as I expect an error!")

  });
});
