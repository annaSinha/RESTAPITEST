@isTest
    global class AccountLinkQueueableMock implements HttpCalloutMock{
    
      protected Integer code;
        protected String status;
        protected String body;
        protected Map<String, String> responseHeaders;

        public AccountLinkQueueableMock(Integer code, String status, String body, Map<String, String> responseHeaders) {
            this.code = code;
            this.status = status;
            this.body = body;
            this.responseHeaders = responseHeaders;
        }

        public HTTPResponse respond(HTTPRequest req) {

            HttpResponse res = new HttpResponse();
            for (String key : this.responseHeaders.keySet()) {
                res.setHeader(key, this.responseHeaders.get(key));
            }
            String json=		'{'+
        	'  "items": ['+
        	'    {'+
        	'      "color": "red",'+
        	'      "externalId": "123456",'+
        	'    }'+
        	'  ]'+
        	'}';
            res.setBody(json);
            res.setStatusCode(this.code);
            res.setStatus(this.status);

            return res;
        }
    }