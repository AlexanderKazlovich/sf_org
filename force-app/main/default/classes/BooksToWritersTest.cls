@isTest
private class BooksToWritersTest {
    @testSetup
    static void setup() {
        List<Book__c> books = new List<Book__c>();
        List<Writer__c> writers = new List<	Writer__c>();
        // insert 200 book
        for (Integer i=0;i<200;i++) {
            books.add(new Book__c(name='Book '+i,
                Author__c='Author ' + i, ISBN__c = 0));
        }
        insert books;
        // find the account just inserted. add contact for each
        for (Integer i=0;i<200;i++) {
            writers.add(new Writer__c(name='Author '+i));
        }
        insert writers;
    }
    @isTest static void test() {
        Test.startTest();
        BooksToWritersBatch myBatchObject = new BooksToWritersBatch();
		Id batchId = Database.executeBatch(myBatchObject);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        Map<String, Id> namesMap = new Map<String, Id>();
        List<Writer__c> writers = new List<Writer__c>([Select Id, Name From Writer__c]);
        for(Writer__c writer: writers){
            namesMap.put(writer.Name, writer.Id);
        }
        
        List<Book__c> books = new List<Book__c>([Select Author__c, (Select Writer__c From BooksToWriters__r) From Book__c]);
        for(Book__c book: books){
            for(BooksToWriters__c btw: book.BooksToWriters__r){
            	System.assertEquals(btw.Writer__c, namesMap.get(book.Author__c));    
            }
        }
   
    }
}