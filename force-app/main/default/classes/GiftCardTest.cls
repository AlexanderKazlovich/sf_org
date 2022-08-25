@isTest
public class GiftCardTest {

    @isTest static void applyGiftCard() {
        
    Gift_Card__c card = new Gift_Card__c(Active__c=True, Amount__c=100);
    
    insert card; 
    System.debug(card.Id);  
    String cardId = card.Id;
    List<Gift_Card__c> cardName = [Select Name From Gift_Card__c Where Id = :cardId];
    System.debug(cardName); 
    Opportunity opp1 = new Opportunity(Name='OpportunityTest1',
                                           StageName='Prospecting',
                                           CloseDate=System.today().addMonths(1),
                                           Amount=200
                                     	   );
     insert opp1;
     String oppId = opp1.Id;
     Opportunity newopp1 = [Select Id, Gift_Card_Name__c From Opportunity Where Id = :oppId];
     newopp1.Gift_Card_Name__c = cardName[0].Name;
     System.debug(cardName[0].Name);
        
     Test.startTest();   
     update newopp1;
     Database.SaveResult result = Database.update(newopp1, false);
     Test.stopTest();
     
     Opportunity newopp2 = [Select Id, Amount From Opportunity Where Name='OpportunityTest1'];
     Gift_Card__c cardNameNew = [Select Active__c From Gift_Card__c Where Id = :cardId];
     system.debug(result);   
     System.assertEquals(newopp2.Amount, 100);
     System.assertEquals(cardNameNew.Active__c, False);
     System.assertEquals('Cannot use inactive gift card.', result.getErrors()[0].getMessage());

    }
}