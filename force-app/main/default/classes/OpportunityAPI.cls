@RestResource(urlMapping='/Opportunities/*')
global with sharing class OpportunityAPI {
    /**
     * GET /services/apexrest/Opportunities
     * Returns a list of Opportunity records (customize fields as needed)
     */
    @HttpGet
    global static List<Opportunity> doGet() {
        // You can add WHERE conditions or LIMIT as needed
        return [
            SELECT Id, Name, StageName, Amount, CloseDate, Owner.Name
            FROM Opportunity
            ORDER BY LastModifiedDate DESC
            LIMIT 100
        ];
    }
}