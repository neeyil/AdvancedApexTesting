//1. Brute force method of creating test data
// cons - Brute force can work well, but it can lead to lengthy tests that are hard to follow.

@IsTest
private class DataGenerationTests {
  // 3. TestSetup Methods - Multiple test methods in the same class often have similar data requirements...
  @TestSetup
  static void dataCreation() {
    // GIVEN
    Account a = TestFactory.getAccount('Muddy Waters Inc.', true);
    Contact c = TestFactory.getContact(a.id, 'Muddy', 'Waters', true);
    Opportunity opp = new Opportunity();
    opp.name = 'Long lost record';
    opp.accountId = a.id;
    opp.closeDate = Date.today().addDays(14);
    opp.stageName = 'prospecting';
    insert opp;
  }
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

  @IsTest
  static void testUseTestFactoryToCreateAccountsWithContacts() {
    // GIVEN
    List<Account> accts;
    List<Contact> contacts;
    TestFactory.generateAccountWithContacts(5);
    // WHEN
    Test.startTest(); //This resets governor limits and isolates your test from test setup.
    accts = [SELECT Id FROM Account];
    contacts = [SELECT Id FROM Contact];
    Test.stopTest(); // This forces any asynchronous code to complete.
    // THEN
    Assert.isTrue(
      accts.size() > 0,
      'Was expecting to find at least one account'
    );
    Assert.areEqual(5, contacts.size(), 'Was expecting to find 5 contacts');
  }

  @IsTest
  static void testAtTestSetupMethodsRule() {
    // WHEN
    List<Opportunity> opps = [SELECT Id, AccountId FROM Opportunity];
    // THEN
    Assert.areEqual(1, opps.size(), 'Expected test to find a single Opp');
  }
}
