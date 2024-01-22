public class SecurityTriggerHandler {
    public static Boolean isExecuting = false;
    
    public static void filldescription(List<Account> accList) {
        try {
            if (isExecuting) {
                return;
            }
            
            isExecuting = true;
            
            Set<Id> accIds = new Set<Id>();
            for (Account acc : accList) {
                accIds.add(acc.Id);
            }
            if (Schema.sObjectType.Account.fields.Description.isUpdateable()) {
            List<Account> accountsToUpdate = [SELECT Id, Description FROM Account WHERE Id = :accIds];
            List<Account> accountsToUpdateWithNewDescription = new List<Account>();
            
            if (!accountsToUpdate.isEmpty()) {
                for (Account accToUpdate : accountsToUpdate) {
                    accToUpdate.Description = 'This is a sample description.';
                    accountsToUpdateWithNewDescription.add(accToUpdate);
                    System.debug('Account Name => ' + accToUpdate.Description);
                }
                
                update accountsToUpdateWithNewDescription;
            }
            }
            isExecuting = false;
        } catch (Exception ex) {
            System.debug('Error Occurred => ' + ex.getMessage());
        }
    }
}