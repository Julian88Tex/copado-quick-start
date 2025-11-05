@RestResource(urlMapping='/OpportunitiesWithLineItems/*')
global with sharing class OpportunityAPIWithLineItems {
    /**
     * GET /services/apexrest/OpportunitiesWithLineItems
     * Returns a list of Opportunity records with associated OpportunityLineItems
     */
    @HttpGet
    global static List<OpportunityWrapper> doGet() {
        List<OpportunityWrapper> results = new List<OpportunityWrapper>();
        // Query Opportunities with related OpportunityLineItems
        List<Opportunity> opps = [
            SELECT Id, Name, StageName, Amount, CloseDate, Owner.Name,
                   (SELECT Id, Quantity, UnitPrice, TotalPrice, Product2.Name FROM OpportunityLineItems)
            FROM Opportunity
            ORDER BY LastModifiedDate DESC
            LIMIT 100
        ];
        for (Opportunity opp : opps) {
            OpportunityWrapper wrap = new OpportunityWrapper();
            wrap.opp = opp;
            wrap.lineItems = opp.OpportunityLineItems;
            results.add(wrap);
        }
        return results;
    }
    // Wrapper class for Opportunity and its Line Items
    global class OpportunityWrapper {
        public Opportunity opp;
        public List<OpportunityLineItem> lineItems;
    }
}