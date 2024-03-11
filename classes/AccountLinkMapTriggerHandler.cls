public class AccountLinkMapTriggerHandler {

    public static void updateAccountLinkMap(Map<Id, AccountLink__c> accLinkMap){
        List<AccountLink__c> accLinkRecs = new List<AccountLink__c>();
        List<Account> accounts =[SELECT Id, ExternalId__c, Color__c FROM Account WHERE ExternalId__c IN: accLinkMap.keySet() LIMIT 50000];
        if(!accounts.isEmpty()){
            for(Account acc : accounts){
                if(accLinkMap.containsKey(acc.ExternalId__c) && accLinkMap.get(acc.ExternalId__c).Color__c == acc.Color__c){
                    AccountLink__c accObj = new AccountLink__c();
                    accObj.Id = accLinkMap.get(acc.ExternalId__c).Id;
                    accObj.AccountId__c = acc.Id;
                    accLinkRecs.add(accObj);
                }
            }
            if(!accLinkRecs.isEmpty()){
                update accLinkRecs;
                List<AccountLinkWrapper> wraplist = new List<AccountLinkWrapper>();
                for(AccountLink__c accLink : accLinkRecs){
                    AccountLinkWrapper obj = new AccountLinkWrapper();
                    obj.accountId = accLink.AccountId__c;
                    obj.accountLinkId = accLink.Id;;
                    wraplist.add(obj);
                }
                FinalJSON jsonReq = new FinalJSON();
                jsonReq.items = wraplist;
                String jsonRequest = JSON.serialize(jsonReq);
                System.enqueueJob(new AccountLinkQueueable(jsonRequest));
            }
        }
    }
    public class FinalJSON{
        public List<AccountLinkWrapper> items;
    } 
        public class AccountLinkWrapper {
        public String accountId;
        public String accountLinkId;
    }
        
}