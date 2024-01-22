trigger AutofillEnddate on SBQQ__Quote__c (before insert, before update) {
    for(SBQQ__Quote__c qu: trigger.new){
         if (qu.SBQQ__StartDate__c != null && qu.SBQQ__SubscriptionTerm__c != null) {
            qu.SBQQ__EndDate__c = qu.SBQQ__StartDate__c.addMonths(qu.SBQQ__SubscriptionTerm__c.intValue());
        }
    }
}