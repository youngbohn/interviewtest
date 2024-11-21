public class LeadRepository extends AbstractRepository {
    
    public Lead findById(Id leadId){
        return [SELECT Id, FirstName, LastName, Email FROM Lead WHERE Id = :leadId];
    }
    
}