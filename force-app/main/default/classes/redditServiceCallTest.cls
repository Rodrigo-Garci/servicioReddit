@isTest
private class redditServiceCallTest {

    @isTest
    static void testrunRedditServiceCallSync_Success(){

        Http http = new Http();
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setBody('{"data": {"children": [{"data": {"thumbnail": "thumbnail test", "title": "title test", "author_fullname": "author_fullname_test", "created": 1686548955}}]}}');

        Test.setMock(HttpCalloutMock.class, new RedditCalloutMock(res));

        Test.startTest();
        redditServiceCall.runRedditServiceCallSync();
        Test.stopTest();

        List<reddit_items__c> insertedRecords = [SELECT Id, Thumbnail__c FROM reddit_items__c];
        system.assertEquals(1, insertedRecords.size());
        system.assertEquals('thumbnail test', insertedRecords[0].Thumbnail__c);

    }

    @isTest
    static void testrunRedditServiceCallSync_Failure(){

        Http http = new Http();
        HttpResponse res = new HttpResponse();
        res.setStatusCode(404);
        res.setBody('Improperly formatted request, review request and try again');

        Test.setMock(HttpCalloutMock.class, new RedditCalloutMock(res));

        Test.startTest();
        redditServiceCall.runRedditServiceCallSync();
        Test.stopTest();

        List<reddit_items__c> insertedRecords = [SELECT Id FROM reddit_items__c];
        system.assertEquals(0, insertedRecords.size());

    }

    private class RedditCalloutMock implements HttpCalloutMock {
        HttpResponse res;

        public RedditCalloutMock(HttpResponse r){
            res = r;
        }

        public HttpResponse respond(HttpRequest req){
            return res;
        }
    }

}