public with sharing class redditItemsHandler {

    @AuraEnabled(Cacheable=true)
    public static List<reddit_items__c> getRedditRecords() {
        try {
            List<reddit_items__c> redditRecords = [SELECT Id, Thumbnail__c, Author_Fullname__c, Created__c, Selftext__c,  Title__c FROM reddit_items__c ORDER BY Created__c DESC];

            return redditRecords;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void deteleRedditRecord(Id itemId){
        try {
            delete [SELECT Id FROM reddit_items__c WHERE Id =: itemId];
        } catch (DmlException  e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}