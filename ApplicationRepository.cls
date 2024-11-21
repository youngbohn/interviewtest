public class ApplicationRepository extends AbstractRepository {
    
    public List<Application__c> findByLeadId(Id leadId) {
        return [SELECT Id, Status__c FROM Application__c WHERE LeadId__c =: leadId];
    }
    
}