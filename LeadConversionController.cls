public class LeadConversionController {

    public static void passApplicant(Id leadId) {
        Lead leadToConvert = [SELECT Id, FirstName, LastName, Email FROM Lead WHERE Id = :leadId];

        String personAccountRecordTypeId = '0123XYZ000000AAA';

        // Application__c is linked to lead we want to update the application trelated to lead to confirmed after the lead conversion
        // QUERY
        // DML

        try {
            calloutToExternalSystem(leadToConvert.Email);

            Database.LeadConvert lc = new Database.LeadConvert();
            lc.setLeadId(leadId);
           
            lc.setAccountId(null); /
            lc.setDoNotCreateOpportunity(true);

            lc.setContactId(null);

            Database.LeadConvertResult result = Database.convertLead(lc);

            if (!result.isSuccess()) {
                throw new ConversionException('Lead conversion failed for unknown reason');
            }
        } catch (Exception ex) {
            System.debug('Error occurred during Lead conversion: ' + ex.getMessage());
            throw new ConversionException('Error occurred during Lead conversion: ' + ex.getMessage());
        }
    }

    @future(callout=true)
    public static void Callout(String leadEmail) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://example.com/api/sendEmail');
        request.setMethod('POST');
        request.setBody('{"email": "' + leadEmail + '"}');
       
        HttpResponse response = http.send(request);
        if (response.getStatusCode() != 200) {
            System.debug('Failed to send email for lead: ' + response.getStatus());
        }
    }

    public class ConversionException extends Exception {}

}