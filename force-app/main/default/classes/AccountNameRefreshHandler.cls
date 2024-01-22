public with sharing class AccountNameRefreshHandler {
    @AuraEnabled
    public static string updateAccountName(String Id, String Name){
        try {
            Account acc =[SELECT Id, Name from Account WHERE Id =: Id Limit 1];
            acc.Name = Name;
            update acc;
            return acc.Id;
            
        } catch (Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }
}