public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String recordId) {

        return [
            SELECT FirstName, LastName, Email, Phone
           FROM Contact
           WHERE AccountId =:recordId
         WITH SECURITY_ENFORCED
         ORDER BY FirstName
     ];
     
    }
}