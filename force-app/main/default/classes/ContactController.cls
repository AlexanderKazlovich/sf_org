public with sharing class ContactController {
    @AuraEnabled(Cacheable=true)
    public static List<Contact> getContacts(String accountId) {
        return [SELECT
                    FirstName,
                    LastName,
                    Email,
                    Phone
                FROM
                    Contact
                WHERE
                    AccountId =: accountId
                WITH SECURITY_ENFORCED
                ORDER BY FirstName
     ];
    }
}
