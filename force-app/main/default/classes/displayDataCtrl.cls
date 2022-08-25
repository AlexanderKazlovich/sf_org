public class displayDataCtrl {      
    
    @AuraEnabled
    public static List<Opportunity> oppListData(String recordId, String filter) {
        system.debug(filter);
        system.debug(recordId);
        
        String stringFilter = ' ';
        if(filter != null){
           stringFilter = ' AND Name like:filter ';
        }
                    
        List<Opportunity> oppList = Database.query('SELECT Name, Amount, ExpectedRevenue, Probability, StageName, CloseDate FROM Opportunity WHERE AccountId =:recordId'+stringFilter+'ORDER BY createdDate ASC');
        system.debug(oppList);  
        return oppList;    
    }
    
}