public class SalesforceAPI {
    // login credentials to the org
    static String loginUrl = 'https://MyDomainName.my.salesforce.com';
    static String username = 'admin.user@company.com';
    static String password = 'password';
    static String accessToken = 'your_access_token'; // replace with your access token

    // quote and product details
    static String quoteId = 'a0bA000000FW2o4';
    static String productId = '01tA0000005NsiA';
    static String pricebookId = '01tA0000005NsiA';
    static String currencyCode = 'USD';

    @future(callout=true) // for asynchronous processing
    public static void callSalesforceAPI() {
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + accessToken);
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint(loginUrl + '/services/data/v48.0/query?q=SELECT+name+from+Account');
        req.setMethod('GET');

        Http http = new Http();
        HttpResponse res = http.send(req);

        // parse the JSON response
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());

        // further processing...
    }
}