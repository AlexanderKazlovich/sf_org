public class BooksToWritersSchedulable implements Schedulable {
    
    // Execute at regular intervals
    public void execute(SchedulableContext sc){
		BooksToWritersBatch myBatchObject = new BooksToWritersBatch();
		Database.executeBatch(myBatchObject, 200);      
    }
}