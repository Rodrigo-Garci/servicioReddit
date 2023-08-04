public with sharing class redditServiceCall {

    private static STRING REDDIT_URL = 'https://www.reddit.com/r/subreddit/new.json?sort=new';

    public static void runRedditServiceCallSync() {

        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(REDDIT_URL);
        req.setMethod('GET');

        HttpResponse res = http.send(req);

        if (res.getStatusCode() == 200) {
            
            Map<String, Object> redditInfo = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
            System.debug(redditInfo);

            Map<String, Object> dataMap = (Map<String,Object>) redditInfo.get('data');
            System.debug(dataMap);

            List<Object> childrenList = (List<Object>) dataMap.get('children');

            List<reddit_items__c> redditItemList = new List<reddit_items__c>();

            for (Object c : childrenList) {
                Map<String, Object> childMap = (Map<String, Object>) c;
                Map<String, Object> childDataMap = (Map<String, Object>) childMap.get('data');

                reddit_items__c redditItem = new reddit_items__c(
                    Author_Fullname__c = (String) childDataMap.get('author_fullname'),
                    Thumbnail__c = (String) childDataMap.get('thumbnail'),
                    Title__c = (String) childDataMap.get('title'),
                    Selftext__c = (String) childDataMap.get('selftext'),
                    Created__c = (Decimal) childDataMap.get('created')
                );
                redditItemList.add(redditItem);
            }
            
            if (!redditItemList.isEmpty()) {
                insert redditItemList;
            }
            
        }

        if (res.getStatusCode() == 404) {
            system.debug('Improperly formatted request, review request and try again');
        }
        

    }

}