public virtual class OutboundService {

    ServiceProvider__mdt serviceProvider;

    private virtual void setServiceProvider(String serviceProviderDeveloperName){
       serviceProvider = ServiceProvider__mdt.getInstance(serviceProviderDeveloperName);
    }
    
    public virtual String handleResponse(HttpRequest request, HttpResponse response){
        
        if (response.getStatusCode() != 200) {
            throw new IntegrationException(request, response);
        }

        return response.getBody();        
    }
    
    public class IntegrationException extends Exception {
        public HttpRequest httpRequest;
        public HttpResponse httpResponse;

        public IntegrationException(HttpRequest httpRequest, HttpResponse httpResponse ){
            this.httpRequest = httpRequest;
            this.httpResponse = httpResponse;
        }
    }
}