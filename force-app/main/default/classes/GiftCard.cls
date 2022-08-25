public class GiftCard {
    
    public void applyGiftCard(List<Opportunity> newOpportunities, Map<Id, Opportunity> newOpportunitiesMap, Map<Id, Opportunity> oldOpportunitiesMap){  
        
        Map<String, Decimal> giftDiscounts = new Map<String, Decimal>();		
        Set<String> inactiveCards = new Set<String>();    
        
        for(Opportunity opp: newOpportunities) {
            giftDiscounts.put(opp.Gift_Card_Name__c, 0);
        }
        
        for(Gift_Card__c giftCard: [SELECT Name, Amount__c, Active__c
                                    FROM Gift_Card__c 
                                    WHERE Name = :giftDiscounts.keySet()]) {                                   
                                        if(giftCard.Active__c == False){
                                            inactiveCards.add(giftCard.Name);	    
                                        } else {
                                            giftDiscounts.put(giftCard.Name, giftCard.Amount__c);
                                        }
                                    }
        
        for(Opportunity opp: newOpportunities) {
            
            opp.Amount = opp.Amount - giftDiscounts.get(opp.Gift_Card_Name__c);
            
        }
        List<Gift_Card__c> allGiftCards = [SELECT Name FROM Gift_Card__c];
        List<String> allGiftCardsName = new List<String>();
        for (Gift_Card__c giftCard: allGiftCards){
            allGiftCardsName.add(giftCard.Name);
        }
        
        for(Opportunity opp: newOpportunities){
            if (newOpportunitiesMap == null && oldOpportunitiesMap == null) {
                if((inactiveCards.contains(opp.Gift_Card_Name__c) || (allGiftCardsName.contains(opp.Gift_Card_Name__c) == False))){
                    opp.Gift_Card_Name__c.addError(System.Label.Gift_Card_Message);
                }
            } else{
                if((newOpportunitiesMap.get(opp.id).Gift_Card_Name__c != oldOpportunitiesMap.get(opp.id).Gift_Card_Name__c)
                   &&(inactiveCards.contains(opp.Gift_Card_Name__c) || (allGiftCardsName.contains(opp.Gift_Card_Name__c) == False))){
                       newOpportunitiesMap.get(opp.Id).Gift_Card_Name__c.addError(System.Label.Gift_Card_Message);        
                   }
            }
        }
    }       
    
    
    public void updateGiftCards(List<Opportunity> newOpportunities){
        List<String> giftCardsName = new List<String>();
        List<Gift_Card__c> giftCardsToUpdate = new List<Gift_Card__c>();
        
        for(Opportunity opp: newOpportunities) {
            giftCardsName.add(opp.Gift_Card_Name__c);
        }
        
        for(Gift_Card__c giftCard: [SELECT Name, Amount__c, Active__c
                                    FROM Gift_Card__c 
                                    WHERE Name = :giftCardsName]) {                                   
                                        if(giftCard.Active__c != False){
                                            giftCard.Active__c = False;
                                            giftCardsToUpdate.add(giftCard);
                                        }
                                    }
        
        update giftCardsToUpdate;
    }
}