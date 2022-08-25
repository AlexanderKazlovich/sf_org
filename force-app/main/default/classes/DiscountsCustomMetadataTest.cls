@isTest
private class DiscountsCustomMetadataTest {
    @isTest static void TestOpportunityDiscount() {
        
        Discounts__mdt[] discounts = [SELECT Cooperation_Time__c, Discount_percentage__c 
                                      FROM Discounts__mdt 
                                      ORDER BY Cooperation_Time__c];
        
        Date thistoday = Date.today();
        List<Account> accountsToInsert = new List<Account>();
        Account acct0 = new Account(Name='Test Account 0', Registration_Date__c = thistoday);
        Account acct1 = new Account(Name='Test Account 1', Registration_Date__c = thistoday.addMonths(-12));
        Account acct2 = new Account(Name='Test Account 2', Registration_Date__c = thistoday.addMonths(-24));
        Account acct3 = new Account(Name='Test Account 3', Registration_Date__c = thistoday.addMonths(-36));
        Account acct4 = new Account(Name='Test Account 4', Registration_Date__c = thistoday.addMonths(-48));
        
        accountsToInsert.add(acct0);
        accountsToInsert.add(acct1);
        accountsToInsert.add(acct2);
        accountsToInsert.add(acct3);
        accountsToInsert.add(acct4);
        
        insert accountsToInsert;
        
        Opportunity opp0 = new Opportunity(Name=acct0.Name + ' Opportunity',
                                           StageName='Prospecting',
                                           CloseDate=System.today().addMonths(1),
                                           AccountId=acct0.Id,
                                           Amount = 100);
        Opportunity opp1 = new Opportunity(Name=acct1.Name + ' Opportunity',
                                           StageName='Prospecting',
                                           CloseDate=System.today().addMonths(1),
                                           AccountId=acct1.Id,
                                           Amount = 100);
        Opportunity opp2 = new Opportunity(Name=acct2.Name + ' Opportunity',
                                           StageName='Prospecting',
                                           CloseDate=System.today().addMonths(1),
                                           AccountId=acct2.Id,
                                           Amount = 100);
        Opportunity opp3 = new Opportunity(Name=acct3.Name + ' Opportunity',
                                           StageName='Prospecting',
                                           CloseDate=System.today().addMonths(1),
                                           AccountId=acct3.Id,
                                           Amount = 100);
        Opportunity opp4 = new Opportunity(Name=acct4.Name + ' Opportunity',
                                           StageName='Prospecting',
                                           CloseDate=System.today().addMonths(1),
                                           AccountId=acct4.Id,
                                           Amount = 100);
        
        //insert opp;
        List<String> accountsId = new List<String>();
        accountsId.add(acct0.Id);
        accountsId.add(acct1.Id);
        accountsId.add(acct2.Id);
        accountsId.add(acct3.Id);
        accountsId.add(acct4.Id);
        
        List<Opportunity> opportunities = new List<Opportunity>();
        opportunities.add(opp0);
        opportunities.add(opp1);
        opportunities.add(opp2);
        opportunities.add(opp3);
        opportunities.add(opp4);
        
        
        Test.startTest();
        insert opportunities;
        Test.stopTest();
        
        List<Opportunity> newOpportunities = new List<Opportunity>([Select Id, Amount 
                                                                    From Opportunity 
                                                                    Where AccountId IN:accountsId]);
        
        System.debug(newOpportunities);
        
        System.assertEquals(newOpportunities[0].Amount, 100);
        System.assertEquals(newOpportunities[1].Amount, 100 - discounts[0].Discount_percentage__c);
        System.assertEquals(newOpportunities[2].Amount, 100 - discounts[1].Discount_percentage__c);
        System.assertEquals(newOpportunities[3].Amount, 100 - discounts[2].Discount_percentage__c);
        System.assertEquals(newOpportunities[4].Amount, 100 - discounts[3].Discount_percentage__c);
        
        
    }
}