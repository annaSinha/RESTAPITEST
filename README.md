# RESTAPITEST


ACTIVITIES WE NEED TO DO IN DEV ORG 

1) Create a remote site setting for the URL of External Systems (both first and second system).

2) Create a custom metadata or named credential to store the Consumer key, Consumer secret provided by  first external system.


Component list  :

Created web service class to post data from external system to salesforce as stated in code test
Component Name  : CreateAccountLinkWebServiceClass.cls

Created Apex trigger to map account on Accountlink object, later same class handler is calling queuable class which is calling second callout


Component Name  : AccountLinkMapTrigger.trigger, AccountLinkMapTriggerHandler.cls, AccountLinkQueueable.cls
