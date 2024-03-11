/**
 *
 * @author Anna Sinha
 * @since 2024-03-11
 */
trigger AccountLinkMapTrigger on AccountLink__c (After Insert) {

    Map<Id, AccountLink__c> accLinkMap = new Map <Id, AccountLink__c>();
    for(AccountLink__c rec : trigger.new){
        if(rec.Color__c != null && rec.ExternalId__c != null){
            accLinkMap.put(rec.ExternalId__c, rec);
        }
    }
    if(!accLinkMap.isEmpty()){
        AccountLinkMapTriggerHandler.updateAccountLinkMap(accLinkMap);
    }
    
}
