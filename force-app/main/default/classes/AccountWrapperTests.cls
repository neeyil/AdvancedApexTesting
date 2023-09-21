@isTest
public class AccountWrapperTests {
  @TestSetup
  static void loadTestData() {
    // GIVEN
    Account acct = new Account(Name = 'ACME');
    insert acct;
    List<Opportunity> opps = TestFactory.generateOppsForAccount(
      acct.id,
      1000.00,
      5
    );
    insert opps;

    // GIVEN
    Account acct1 = new Account(Name = 'ACME1');
    insert acct1;
    List<Opportunity> opps1 = TestFactory.generateOppsForAccount(
      acct1.id,
      1000000.00,
      5
    );
    insert opps1;
  }
  @IsTest
  static void testPositiveRoundedAveragePrice() {
    // WHEN
    Account acct = [SELECT Id FROM Account LIMIT 1];
    AccountWrapper acctWrapper = new AccountWrapper(acct);
    // THEN
    Test.startTest();
    Assert.areEqual(
      acctWrapper.getRoundedAvgPriceOfOpps(),
      1000.00,
      'Expected to get 1000.00'
    );
    Test.stopTest();
  }
  @isTest
  static void isHighPriority() {
    // WHEN
    Account acct = [SELECT Id FROM Account LIMIT 1];
    AccountWrapper acctWrapper = new AccountWrapper(acct);

    // WHEN
    Account acct1 = [SELECT Id FROM Account LIMIT 1];
    AccountWrapper acctWrapper1 = new AccountWrapper(acct1);

    // THEN
    Test.startTest();
    Assert.areEqual(acctWrapper.isHighPriority(), false, 'Expected to false');
    // Test.stopTest();

    // Test.startTest();
    // Assert.areEqual(acctWrapper1.isHighPriority(), false, 'Expected to false');
    Test.stopTest();
  }

  @IsTest
  static void testNegativeAccountWrapperAvgPriceOfOpps() {
    // GIVEN
    Account acct = [SELECT Id FROM Account LIMIT 1];
    List<Opportunity> opps = [
      SELECT Amount
      FROM Opportunity
      WHERE accountId = :acct.Id
    ];
    for (Opportunity o : opps) {
      o.Amount = 0;
    }
    update opps;
    AccountWrapper acctWrapper = new AccountWrapper(acct);
    // WHEN
    try {
      Test.startTest();
      acctWrapper.getRoundedAvgPriceOfOpps();
      Test.stopTest();
      Assert.fail('An exception should have been thrown');
    } catch (AccountWrapper.AWException e) {
      // THEN
      Assert.isTrue(
        e.getMessage().equalsIgnoreCase('no won opportunities'),
        'Exception message does not match: ' + e.getMessage()
      );
    }
  }
}
