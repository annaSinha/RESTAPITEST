/**
 *
 * @author Anna Sinha
 * @since 2024-03-11
 */
public with sharing class AccountLinkQueueable implements Queueable, Database.AllowsCallouts {
    private String jsonBody;

	public AccountLinkQueueable(String jsonString) {
		this.jsonBody = jsonString;
	}
    public void execute(QueueableContext context) {
        List<AccountLinkWrapper> items = new List<AccountLinkWrapper>();
        for (AccountLink__c anrec : this.recordList){

        }
		Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://www.marcbenioff.com/v1/v2/'); // we can store the endpoint in named credential
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Set the body as a JSON object
        request.setBody(jsonString);
        HttpResponse response = http.send(request);
        // Parse the JSON response
        if (response.getStatusCode() == 200) {
            System.debug('The status code returned was not expected: ' +response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }

	}

}
