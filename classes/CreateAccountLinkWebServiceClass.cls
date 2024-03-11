/**
 *
 * @author Anna Sinha
 * @since 2024-03-11
 */
@RestResource(URLMapping = '/AccountLinkInsert/*')
global with sharing class CreateAccountLinkWebServiceClass {

   @HttpPost
    global static void createAccountLinkData(){

        RestContext.response.addHeader('Content-Type', 'text/plain');

        RestRequest request = RestContext.request;

        RestResponse resp = RestContext.response;
        List<AccountLink__c> accLinkRecs = new List<AccountLink__c>();
        //Access the request body with input data coming in the JSON format  
        Map<String,Object> responseMap = (Map<String,Object>) JSON.deserializeUntyped(request.requestBody.toString());
        List<Object> itemsList = (List<Object>)responseMap.get('items');
        for(Object obj : itemsList){
                Map<String,Object> itemMap = (Map<String,Object>) obj;
                AccountLink__c accObj = new AccountLink__c();
                accObj.Color__c = itemMap.get('color');//Color__c is custom field 
                accObj.ExternalId__c= itemMap.get('externalId');//ExternalId__c is custom field 
                accLinkRecs.add(accObj);

        }
        if(!accLinkRecs.isEmpty()){
            insert accLinkRecs;
        }
        
    }
}
