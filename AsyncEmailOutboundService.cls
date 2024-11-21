public class AsyncEmailOutboundService implements Queueable, Database.AllowsCallouts {
    
    EmailOutboundService outboundService;
    public List<String> emailsToNotify;
    
    public AsyncEmailOutboundService(String emailToNotify){
        this();
        this.emailsToNotify = new List<String>{ emailToNotify };
    }
    public AsyncEmailOutboundService(List<String> emailsToNotify){
        this();
        this.emailsToNotify = emailsToNotify;
    }

    public AsyncEmailOutboundService(){
        outboundService = new EmailOutboundService();
    }

    public void execute(QueueableContext context) {
        try {
            notify(emailsToNotify); 
        }  catch (Exception ex) {
            Logger.error(ex.getMessage()).setExceptionDetails(ex);
        }

        Logger.saveLog();
    }

    void send(List<String> emailsToNotify) {
        for (String currentEmail : emailsToNotify) {
            send(currentEmail);
        }
    }

    void send(String currentEmail){
        try{
            outboundService.notify(currentEmail);
        } catch(OutboundService.CalloutException ex){
            Logger.error('EmailOutboundService - Bad Callout - Code: ' + ex.httpResponse.getStatusCode());
            Logger.error('Server Response Body: \n' + ex.httpResponse.getBody());
            Logger.error('Requested Endpoint: ' + ex.httpRequest.getEndpoint() + '\n\n Request body: \n' + ex.httpRequest.getBody())
        }
    }
}
