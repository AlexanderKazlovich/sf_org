public class OpportunityTriggerHandler {
    
    public void beforeInsert(List<Opportunity> newOpportunities){
     
        DiscountsCustomMetadata discount_process = new DiscountsCustomMetadata();
        discount_process.updateDiscountsOpp(newOpportunities);    
        doLogicGiftCard(newOpportunities, null, null);
        
    }   
    
    public void beforeUpdate(List<Opportunity> newOpportunities, Map<Id, Opportunity> newOpportunitiesMap, Map<Id, Opportunity> oldOpportunitiesMap){       
        doLogicGiftCard(newOpportunities, newOpportunitiesMap, oldOpportunitiesMap);    
    }
    
     public void afterUpdateInsert(List<Opportunity> newOpportunities){
        GiftCard giftcard_processor = new GiftCard();
        giftcard_processor.updateGiftCards(newOpportunities);
         
    }
    
    public void doLogicGiftCard(List<Opportunity> newOpportunities, Map<Id, Opportunity> newOpportunitiesMap, Map<Id, Opportunity> oldOpportunitiesMap){
        GiftCard giftcard_processor = new GiftCard();
        giftcard_processor.applyGiftCard(newOpportunities, newOpportunitiesMap, oldOpportunitiesMap);
       
    }
    
}