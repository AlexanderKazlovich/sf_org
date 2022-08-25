public class UpdateAccountPhonePrefix implements Database.Batchable<sObject>, Database.Stateful {
   private static final String PHONE_NUMBER_PREFIX = '+38';
   public Integer recordsProcessed = 0;
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT ID, Phone FROM Account');
    }
    
    public void execute(Database.BatchableContext bc, List<Account> scope){
        for(Account account:scope) {
            account.Phone = PHONE_NUMBER_PREFIX + account.Phone;
            recordsProcessed ++;
        }
        update scope;
    }
    
    public void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + 'records processed');
    }

}