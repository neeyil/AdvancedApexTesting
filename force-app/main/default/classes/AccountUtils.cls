public with sharing class AccountUtils {
  public static List<Account> accountsByState(String state) {
    List<Account> myAccounts = [
      SELECT Id, Name
      FROM Account
      WHERE BillingState = :state
    ];
    system.debug(myAccounts);
    return myAccounts;
  }
}
