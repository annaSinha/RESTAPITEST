/**
 *
 * @author Anna Sinha
 * @since 2024-03-11
 */
@IsTest
private class AccountLinkMapTriggerHandlerTest{
    @IsTest
    static void updateAccountLinkMapTest(){

        AnimalLink__c rec = new AnimalLink__c();
        rec.Color__c = 'Red';
        rec.ExternalId__c = '123456';
        insert rec;

        Account acc = new Account();
        acc.name = 'Test Account';
        acc.Color__c ='Red';
        acc.ExternalId__c = '123456';
        insert acc;
        String json=		'{'+
        	'  "items": ['+
        	'    {'+
        	'      "color": "red",'+
        	'      "externalId": "123456",'+
        	'    }'+
        	'  ]'+
        	'}';
        AccountLinkQueueableMock mock = new AccountLinkQueueableMock(200,'SUCCESS',json, new Map<String,String>()); 
        Test.setMock(HttpCalloutMock.class, mock);      
        Test.startTest();
            AccountLinkMapTriggerHandler.updateAccountLinkMap();
        Test.stopTest();

        System.assertEquals(1, [SELECT count()
                                FROM AsyncApexJob
                                WHERE JobType = 'Queueable' and ApexClass.Name = 'AccountLinkQueueable']);
    }
}