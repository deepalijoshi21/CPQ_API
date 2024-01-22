public class CpqEditQuoteApi {
    public static string editAPI(){
        //get access token from custom setting
        CPQ_Acess_Token__c ct = [Select name, Access_Token__c FROM CPQ_Acess_Token__c WHERE name = 'Access Token' LIMIT 1 ];
        String Token = ct.Access_Token__c;
        System.debug('Access token from custom setting ==> '+Token);
        
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://hic31-dev-ed.develop.my.salesforce.com/services/apexrest/SBQQ/ServiceRouter');
        req.setHeader('Content-Type', 'application/json; charset=utf-8');
        req.setHeader('Authorization', 'Bearer '+Token);
        //req.setHeader('Authorization','Bearer 00D2w00000P41A7!AQEAQJR0GK74j3xIlD0UdSOpwrHWVmqYmuT08vugH.TO1Ndn5v6GJ1NkMf3b.x_fHdcVlsmOCUBFFbYKWybgX6hRFpdR6yrW');
    	//req.setBody('{"saver": "SBQQ.QuoteAPI.QuoteSaver", "model": "{\\\"record\\\":{\\\"attributes\\\":{\\\"type\\\":\\\"SBQQ__Quote__c\\\",\\\"url\\\":\\\"/services/data/v59.0/sobjects/SBQQ__Quote__c/a0q2w000004pwH4AAI\\\"},\\\"Name\\\":\\\"Q-00127\\\",\\\"Id\\\":\\\"a0q2w000004pwH4AAI\\\",\\\"SBQQ__Status__c\\\":\\\"Accepted\\\",\\\"ReferralCode__c\\\":\\\"1144\\\"},\\\"netTotal\\\":0.00,\\\"lineItems\\\":[],\\\"lineItemGroups\\\":[],\\\"customerTotal\\\":0.00}"}');
        //req.setBody('{"saver": "SBQQ.QuoteAPI.QuoteSaver", "model": "{\\\"record\\\":{\\\"attributes\\\":{\\\"type\\\":\\\"SBQQ__Quote__c\\\",\\\"url\\\":\\\"/services/data/v59.0/sobjects/SBQQ__Quote__c/01t2w00000EwsnbAAB\\\"},\\\"Name\\\":\\\"Q-00130\\\",\\\"Id\\\":\\\"a0q2w000004pwV3AAI\\\"},\\\"nextKey\\\":2,\\\"netTotal\\\":0.00,\\\"lineItems\\\":[{\\\"record\\\": {\\\"attributes\\\": {\\\"type\\\":\\\"SBQQ__QuoteLine__c\\\"},\\\"SBQQ__Product__c\\\": \\\"01t2w00000EwsnbAAB\\\"},\\\"productQuantityEditable\\\": true,\\\"productHasDimensions\\\": false,\\\"key\\\": 1,\\\"descriptionLocked\\\": false}],\\\"lineItemGroups\\\":[],\\\"customerTotal\\\":0.00}"}');
        
        req.setBody('{"saver": "SBQQ.QuoteAPI.QuoteSaver", "model": "{\\\"record\\\":{\\\"attributes\\\":{\\\"type\\\":\\\"SBQQ__Quote__c\\\",\\\"url\\\":\\\"/services/data/v59.0/sobjects/SBQQ__Quote__c/01t2w00000E04PSAAZ\\\"},\\\"Name\\\":\\\"Q-00132\\\",\\\"Id\\\":\\\"a0q2w000004pwbfAAA\\\"},\\\"nextKey\\\":2,\\\"netTotal\\\":0.00,\\\"lineItems\\\":[{\\\"record\\\": {\\\"attributes\\\": {\\\"type\\\":\\\"SBQQ__QuoteLine__c\\\"},\\\"SBQQ__Product__c\\\": \\\"01t2w00000E04PSAAZ\\\",\\\"SBQQ__ProductFeature__c\\\":\\\"a0h2w000006eEA2AAM\\\",\\\"SBQQ__ProductOption__c\\\":\\\"a0i2w000001LPbKAAW\\\"},\\\"productQuantityEditable\\\": true,\\\"productHasDimensions\\\": false,\\\"key\\\": 1,\\\"descriptionLocked\\\": false}],\\\"lineItemGroups\\\":[],\\\"customerTotal\\\":0.00}"}');
        
        req.setTimeout(120000);
        HttpResponse res = new Http().send(req);
        System.debug(res.toString());
        System.debug(res.getBody());
        System.debug('res' + res);
        System.debug('Response body: ' + res.getBody());

        SBQQ__Quote__c quote = [SELECT Id, CPQ_API_Response__c FROM SBQQ__Quote__c WHERE Id = 'a0q2w000004pwbfAAA']; 
        quote.CPQ_API_Response__c = res.getBody();
        update quote;

        return res.getBody();
    }
}