@RestResource(urlMapping='/Account/*')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccountById() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String AccountId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Name,Phone,Website
                          FROM Account
                          WHERE Id = :AccountId];
        return result;
    }
    @HttpPost
    global static ID createAccount(String name, String phone,
        String website) {
        Account thisAccount = new Account(
            Name=name,
            Phone=phone,
            Website=website);
        insert thisAccount;
        return thisAccount.Id;
    }   
    @HttpDelete
    global static void deleteAccount() {
        RestRequest request = RestContext.request;
        String AccountId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Account thisAccount = [SELECT Id FROM Account WHERE Id = :AccountId];
        delete thisAccount;
    }       
}