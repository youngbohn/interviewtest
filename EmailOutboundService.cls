public class EmailOutboundService extends OutboundService {

    public EmailOutboundService(){
        setServiceProvider('EmailOutboundService');
    }

    public void notify(String leadEmail) {
        HttpRequest request = buildRequest(leadEmail);
        
        handleResponse( request, new Http().send(request) );
    }

    HttpRequest buildRequest(String leadEmail){
        HttpRequest request = new HttpRequest();
        request.setEndpoint(serviceProvider.Endpoint__c);
        request.setMethod(serviceProvider.HttpMethod__c);
        request.setBody( buildRequestBody(leadEmail) );

        return request;
    }

    String buildRequestBody(String leadEmail){
        return JSON.serialize( new Map<String, Object> {
            'email' => leadEmail,
        });
    }
}