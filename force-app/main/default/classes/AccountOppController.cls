public class AccountOppController {
    @auraEnabled
    public static List<Account> getAccounts() {
        return [Select Id, Name From Account];
    }
    @AuraEnabled
    public static List<Opportunity> getOppList(String accId) {
        return [Select Id, Name From Opportunity Where AccountId = :accId];
    }   
    @auraEnabled
    public static List<String> getDetails(String oppId) {        
        Opportunity opp = [Select Id, Name, StageName, CloseDate From Opportunity Where Id = :oppId Limit 1];
        List<String> fldInfo = new List<String>();                                  
        fldInfo.add(opp.StageName);
        fldInfo.add(''+opp.CloseDate);       
        return fldInfo;
    }    
}