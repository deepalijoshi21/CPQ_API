public class URLParameterController {
   public String urlParam {get; set;}
    
    public URLParameterController() { 
        // Get the current page reference 
        ApexPages.PageReference pageRef = ApexPages.currentPage(); 
        String currentUrl = pageRef.getUrl();

        // Use regex to extract 'code' parameter value from the URL
        Pattern p = Pattern.compile('code=([^&]*)');
        Matcher m = p.matcher(currentUrl);
        if (m.find()) {
            urlParam = m.group(1);
        }
        system.debug('Code =='+urlParam);
        String Code = urlParam;
        
        urlParam =  urlParam;//(String)pageRef.getParameters().get('code');
        //if(Code !=''){
           // saveCode();
        //}
    } 

    public void saveCode() {
        String Code = urlParam;        
        //Get custom setting to update access token value
        Authorization_Code__c cat = [Select name, Code__c FROM Authorization_Code__c WHERE name = 'Authorization Code' LIMIT 1 ];
        cat.Code__c = Code;
        database.update(cat);
    }
}


/*
public class URLParameterController {
   public String urlParam {get; set;}
    
    public URLParameterController() { 
        // Get the current page reference 
        ApexPages.PageReference pageRef = ApexPages.currentPage(); 
		String currentUrl = pageRef.getUrl();

 		system.debug('Current URL===>'+currentUrl);
                // Use regex to extract 'code' parameter value from the URL
        Pattern p = Pattern.compile('code=([^&]*)');
        Matcher m = p.matcher(currentUrl);
        if (m.find()) {
            urlParam = m.group(1);
        }
        system.debug('Code =='+urlParam);
        String Code = urlParam;
        
        //Get custom setting to update access token value
        //Authorization_Code__c cat = new Authorization_Code__c();
        //cat.name= 'Authorization Code';
        //cat.Code__c = Code;
        //insert(cat);
        
        
        urlParam = (String)pageRef.getParameters().get('code'); 
        system.debug('urlParam==='+urlParam);
        system.debug(pageRef.getParameters());

    } 
}



/*
public class URLParameterController {
   public String urlParam {get; set;}
    
    public URLParameterController() { 
        // Get the current page reference 
        ApexPages.PageReference pageRef = ApexPages.currentPage(); 
 
        urlParam = pageRef.getParameters().get('code'); 

    } 
} */