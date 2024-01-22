public class CPQAccessToken {
    
    public static void updateAccessToken(){
        
        // Create a new HTTP request object
        HttpRequest req = new HttpRequest();
        
        // Set the endpoint URL
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        // Set the request body in string and pass that string
        String requestBody = 'username=john.carter2107@gmail.com' +
            '&password=Johncarter@7' +
            '&client_id=3MVG9n_HvETGhr3CKHSk_eeHobZ9FCag4AYgMY1r7T..mY_JTx7OHfuQBwCmWE2WyduYsEh42NulZOYQK6ajn' +
            '&client_secret=B6E7D415E70D8686CAC7C675370057DF941F35AE55E85162FF523DF5C420D9B2' +
            '&grant_type=password';
        req.setBody(requestBody);

        Http http = new Http();
        
        // Execute the request
        HttpResponse res = http.send(req);
        
        // Parse the JSON response
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        System.debug(res.getBody());
        
        // Log the access token (you might want to store this in a more secure way)
        System.debug(results.get('access_token'));
        //Get custom setting to update access token value
        CPQ_Acess_Token__c cat = [Select name, Access_Token__c FROM CPQ_Acess_Token__c WHERE name = 'Access Token' LIMIT 1 ];
        cat.Access_Token__c=(String)results.get('access_token');
        database.update(cat);       
    }  
}