public class AccountsCallouts {
    public static HttpResponse makeGetCallout(String accountId) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://polytech-internship-developer-edition.eu40.force.com/services/apexrest/Account/'+accountId);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
       
        if(response.getStatusCode() == 200) {
            
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            
            String getAccountId = (String) results.get('Id');
            String getAccountName = (String) results.get('Name'); 
            String getAccountPhone = (String) results.get('Phone'); 
            String getAccountWebsite = (String) results.get('Website'); 
            
            System.debug('Account Id: ' + getAccountId);
           	System.debug('Account Name: ' + getAccountName);
            System.debug('Account Phone: ' + getAccountPhone);
            System.debug('Account Website: ' + getAccountWebsite);
                
            }
        //System.debug(response.getBody());
        return response;
        }
        
    
    public static HttpResponse makePostCallout(String accountName, String accountPhone, String accountWebsite) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://polytech-internship-developer-edition.eu40.force.com/services/apexrest/Account/');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name":"'+accountName+'", "phone":"'+accountPhone+'", "website":"'+accountWebsite +'"}');
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' +
                response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
        System.debug(response.getBody());
        return response;     	
    }
    
    public static HttpResponse makeDeleteCallout(String accountId) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://polytech-internship-developer-edition.eu40.force.com/services/apexrest/Account/'+accountId);
        request.setMethod('DELETE');
      
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode() == 200) {
            System.debug('Account: ' + accountId + ' was deleted');
        }
        
        System.debug(response.getBody());
        return response;     	
    }   
}