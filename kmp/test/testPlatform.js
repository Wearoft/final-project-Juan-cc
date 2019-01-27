var Platform = artifacts.require("./Platform.sol");

contract('Platform', function(accounts) {
  
  let platformInstance;
  
  before('setup contract for each test', async function () {
    platformInstance = await Platform.deployed();
  });

  it("...should activate circuit breaker.", async() => {
      let activeValue = await platformInstance.activateEmergency.call({from: accounts[0]});
      assert.isTrue(activeValue, "Circuit breaker activation failed.");
  });

  it("...should activate and deactivate circuit breaker.", async() => {
    let activeValue = await platformInstance.activateEmergency.call({from: accounts[0]});
    assert.isTrue(activeValue, "Circuit breaker activation failed.");
    await platformInstance.activateEmergency({from: accounts[0]}); // Updating state
    let deactiveValue = await platformInstance.activateEmergency.call({from: accounts[0]});
    assert.isFalse(deactiveValue, "Circuit breaker deactivation failed.");
  });

  it("...only account[0] should manipulate circuit breaker.", async() => {
    try {
      await platformInstance.activateEmergency({from: accounts[1]});
    } catch (e){
      return true;
    }
    throw new Error("I should never see this as I expect an error!")
  });
 
  it("...trying to createCompany when circuit breaker is active.", async() => {
    let active = await platformInstance.activateEmergency.call({from: accounts[0]});
    assert.isFalse(active, "Circuit breaker was not active.");
    try {
      await platformInstance.createCompany( 
        "companyName",
        "123456789",
        "www.google.com",
        "did:eth:0x2f3fcf4c3",
        "0xdA35deE8EDDeAA556e4c26268463e26FB91ff74f"
      );
    } catch (e) {
      return true;
    }
    throw new Error("I should never see this as I expect an error!")

  });

  it("...trying to getUserTokenBalance from company owner.", async() => {
    try {
      await platformInstance.getUserTokenBalance.call({from: accounts[0]});
    } catch (e) {
      return true;
    }
    throw new Error("I should never see this as I expect an error!")

  });
});
