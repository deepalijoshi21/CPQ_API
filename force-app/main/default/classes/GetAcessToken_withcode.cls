public class GetAcessToken_withcode {
    public static void addAccessToken(){
        Authorization_Code__c cat = [Select name, Code__c FROM Authorization_Code__c WHERE name = 'Authorization Code' LIMIT 1 ];
        String authCode = cat.Code__c;
        System.debug('Authorization Code ==>'+authCode);
        
      	HttpRequest req = new HttpRequest();  
        // Set the endpoint URL
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');

        req.setMethod('POST');
        
        // Set the request header
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        // Set the request body
        String requestBody = 'code='+ authCode +
                             '&client_id=3MVG9n_HvETGhr3CKHSk_eeHobZ9FCag4AYgMY1r7T..mY_JTx7OHfuQBwCmWE2WyduYsEh42NulZOYQK6ajn' +
                             '&client_secret=B6E7D415E70D8686CAC7C675370057DF941F35AE55E85162FF523DF5C420D9B2' +
                             '&grant_type=authorization_code'+'&redirect_uri=https://hic31-dev-ed.develop.lightning.force.com//apex/GetAuthorizationCode?core.apexpages.request.devconsole=1';
        req.setBody(requestBody);
        system.debug('Request Body ==> '+requestBody);

        Http http = new Http();
        
        // Execute the request
        HttpResponse res = http.send(req);
        
        // Parse the JSON response
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
		System.debug(res.getBody());

        System.debug(results.get('access_token'));
        SBQQ__Quote__c quote = [SELECT Id, CPQ_API_Response__c FROM SBQQ__Quote__c WHERE Id = 'a0q2w000004pwV8AAI']; 
        quote.CPQ_API_Response__c = (String)results.get('access_token');
        update quote;
        
        //Get custom setting to update access token value
        //CPQ_Acess_Token__c ct = [Select name, Access_Token__c FROM CPQ_Acess_Token__c WHERE name = 'Access Token' LIMIT 1 ];
        //ct.Access_Token__c=(String)results.get('access_token');
        //database.update(cat); 
		
    }
}