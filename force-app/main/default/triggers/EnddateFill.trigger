trigger EnddateFill on SBQQ__QuoteLine__c (before insert, before update) {
	for(SBQQ__QuoteLine__c qli: trigger.new){
         if (qli.SBQQ__StartDate__c != null && qli.SBQQ__SubscriptionTerm__c != null) {
            qli.SBQQ__EndDate__c = qli.SBQQ__StartDate__c.addMonths(qli.SBQQ__SubscriptionTerm__c.intValue());
        }
    }
}