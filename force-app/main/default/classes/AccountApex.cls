public class AccountApex {
    @AuraEnabled
    public static List<Account> getAccounts() {
        return [SELECT Name FROM Account];
    }
    
    @AuraEnabled
    public static List<Contact> getContactById(Id accountId) {
        return [SELECT LastName FROM Contact WHERE Accountid = :accountId];
    }
    
    @AuraEnabled
    public static List<Opportunity> getOpportunityByAccountId(Id accountId) {
        return [SELECT Name FROM Opportunity WHERE Accountid =: accountId];
    }
}
