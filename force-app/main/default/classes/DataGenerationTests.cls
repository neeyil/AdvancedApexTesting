//1. Brute force method of creating test data
// cons - Brute force can work well, but it can lead to lengthy tests that are hard to follow.

@IsTest
private class DataGenerationTests {
  @IsTest
  static void testBruteForceAccountCreation() {
    // GIVEN
    List<Account> accts;
    Account a = new Account(name = 'McTesterson LLC');

    // WHEN
    Test.startTest(); //Functionally, this isolates your tested code by resetting governor limits
    insert a;
    accts = [SELECT Id FROM Account];
    Test.stopTest();
    // THEN
    Assert.isTrue(
      accts.size() > 0,
      'Was expecting to find at least one account'
    );
  }
}
