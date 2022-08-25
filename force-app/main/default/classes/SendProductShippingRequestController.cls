public class SendProductShippingRequestController {
    
      @AuraEnabled
      public static Integer shippingData(String Id, Integer Quantity, String Address, String Name, Boolean Fee) {
        System.debug('{"id":"'+Id+'", "quantity":'+Quantity+', "address":"'+Address +'", "name":"'+Name +'"}');
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://internship2022dev-developer-edition.na211.force.com/services/apexrest/shippingRequest');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody('{"id":"'+Id+'", "quantity":'+Quantity+', "address":"'+Address +'", "name":"'+Name +'"}');
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode() == 200) {
        	ShippingRequest__c sr = new ShippingRequest__c();
            sr.Product_Name__c = Id;
            sr.Shipping_Quantity__c = Quantity;
            sr.Shipping_Address__c = Address;
            sr.Shipping_Name__c = Name;
            sr.Response__c = response.getBody();
            sr.Take_Shipping_Fee__c = Fee;
            insert sr;
        } else {
            System.debug(response.getStatusCode());
        }
        
        return response.getStatusCode();     	
    }
 }