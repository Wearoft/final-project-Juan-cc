var Token = artifacts.require("./Token.sol");

contract('Token', function(accounts) {
  
  let tokenInstance;
  
  before('setup contract for each test', async function () {
    // setting the token instance deployed during migrations
    tokenInstance = await Token.deployed();
  });

  it("...should transfer 10 tokens.", async() => {
      // transferring 10 tokens from accounts[0] to accounts[1]
      await tokenInstance.transfer(accounts[1],10, {from: accounts[0]});
      // getting accounts[1] balance
      let balance = await tokenInstance.balanceOf.call(accounts[1]);
      // checking accounts[1] new balance is 10
      assert.equal(balance, 10, "The transfer for 10 tokens failed.");
  });

  it("...should transfer 10 more tokens.", async() => {
      // transferring 10 more tokens from accounts[0] to accounts[1]
      await tokenInstance.transfer(accounts[1],10, {from: accounts[0]});
      // getting new accounts[1] balance
      let balance = await tokenInstance.balanceOf.call(accounts[1]);
      // checking accounts[1] new balance is 20
      assert.equal(balance, 20, "The transfer for 10 tokens failed.");
  });

  it("...should error transferring from another account.", async() => {
      try {
        // trying to transfer 10 tokens from account witout tokens, so it should fail
        await tokenInstance.transfer(accounts[1],10, {from: accounts[2]});
      } catch (e){
        // this exception was expected to happen
        return true;
      }
      // if we reached this point we are letting transfers from incorrect accounts.
      throw new Error("I should never see this!")
    });


 
});
