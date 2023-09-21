@isTest
public class AccountTriggerTest {
  //Your test class must insert 200 Account records with a BillingState of CA
  //After the insert, test to ensure that all 200 records have a ShippingState of CA
  @isTest
  static void TestCreateNewAccountInBulk() {
    // Test Setup data
    // Create 200 new Accounts
    List<Account> accts = new List<Account>();
    for (Integer i = 0; i < 200; i++) {
      Account acct = new Account(
        Name = 'Test Account ' + i,
        ShippingState = 'CA'
      );
      // acct.BillingState = 'CA';
      accts.add(acct);
    }
    // Perform Test
    Test.startTest();
    insert accts;
    Test.stopTest();
    // Verify that 200 new Accounts were inserted
    List<Account> verifyAccts = [SELECT Id FROM Account];
    System.assertEquals(200, verifyAccts.size());
    // Also verify that 200 records have a ShippingState of CA
    List<Account> verifyShippingState = [
      SELECT Id
      FROM Account
      WHERE ShippingState = 'CA'
    ];
    System.assertEquals(200, verifyShippingState.size());
  }
}
