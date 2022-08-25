public class BooksToWritersBatch implements
Database.Batchable<sObject>, Database.Stateful {
    // instance member to retain state across transactions
    public Integer recordsProcessed = 0;
    public Database.QueryLocator start(Database.BatchableContext bc) {
        
        return Database.getQueryLocator('SELECT ID, Name, Author__c, (Select Id From BooksToWriters__r) FROM Book__c WHERE Author__c <> Null');
    }
    public void execute(Database.BatchableContext bc, List<Book__c> scope){
        // process each batch of records
        List<BooksToWriters__c> booksToWriters = new List<BooksToWriters__c>();
        
        Map<String, Id> nameToAuthorIdMap = new Map<String, Id>();
        List<Writer__c> writers = new List<Writer__c>([Select Id, Name From Writer__c]);
        for(Writer__c writer: writers){
            nameToAuthorIdMap.put(writer.Name, writer.Id);
        }
        
        for (Book__c book : scope) {
            if(nameToAuthorIdMap.containsKey(book.Author__c)){  
                BooksToWriters__c btw = new BooksToWriters__c();
                btw.Book__c = book.Id;
                btw.Writer__c = nameToAuthorIdMap.get(book.Author__c);
                booksToWriters.add(btw);
                recordsProcessed = recordsProcessed + 1;}    
        }
        upsert booksToWriters;
    }
    
    public void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Shazam!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
                            JobItemsProcessed,
                            TotalJobItems, CreatedBy.Email
                            FROM AsyncApexJob
                            WHERE Id = :bc.getJobId()];
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        String[] toAddresses = new String[] {System.Label.BatchEmail};

        mail.setToAddresses(toAddresses);
        
        mail.setSenderDisplayName('Salesforce Support');
        
        mail.setSubject(recordsProcessed + ' records processed. Shazam!');
        
        mail.setPlainTextBody(recordsProcessed + ' records processed. Shazam!. Job: ' + job);
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }

}