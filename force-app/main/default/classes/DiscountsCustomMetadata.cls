public class DiscountsCustomMetadata {
    
    public void updateDiscountsOpp(List<Opportunity> newOpportunities){
        Discounts__mdt[] discounts = [SELECT Cooperation_Time__c, Discount_percentage__c 
                                      FROM Discounts__mdt 
                                      ORDER BY Cooperation_Time__c];
        Set<String> accountsIds = new Set<String>();
        for(Opportunity opportunityItem : newOpportunities) {
            accountsIds.add(opportunityItem.AccountId);     
        }
        
        Map<ID, Account> accountsToUpdate = new Map<ID, Account>([SELECT Id, Registration_Date__c
                                                                  FROM Account
                                                                  WHERE Id IN: accountsIds]);
        
        Date todaydate = Date.today();
        Decimal discount_procent = 0;
        system.debug(newOpportunities.size());
        for(Opportunity opportunityItem: newOpportunities){
            Account currentAccount = accountsToUpdate.get(opportunityItem.AccountId);
            
            if(currentAccount != Null && currentAccount.Registration_Date__c != Null){
                
                Date regdate = currentAccount.Registration_Date__c;
                Integer months = regdate.monthsBetween(todaydate);
                system.debug(months);
                for(Integer i=0; i<discounts.size() - 1; i++){
                    if(months < discounts[0].Cooperation_Time__c){
                        discount_procent = 0;
                    } else if (discounts[i].Cooperation_Time__c <= months && months < discounts[i+1].Cooperation_Time__c){
                        discount_procent = discounts[i].Discount_percentage__c/100;
                    } else if (discounts[i+1].Cooperation_Time__c < months) {
                        discount_procent = discounts[discounts.size() - 1].Discount_percentage__c/100;
                    }
                }
                if(opportunityItem.Amount != null){
                    opportunityItem.Amount = opportunityItem.Amount - opportunityItem.Amount * discount_procent; 
                }
                System.debug(discount_procent);
                System.debug(opportunityItem.Amount);
                
            }  
        }          
    }    
}