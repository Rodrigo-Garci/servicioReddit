@isTest
public with sharing class redditItemsHandlerTest {

    @isTest
    static void testgetRedditRecords(){

        List<reddit_items__c> testData = new List<reddit_items__c>();
            testData.add(new reddit_items__c(Author_Fullname__c = 'author_fullname',
                                Thumbnail__c = 'thumbnail',
                                Title__c = 'title',
                                Selftext__c = 'selftext',
                                Created__c = 1234));

                testData.add(new reddit_items__c(Author_Fullname__c = 'author_fullname2',
                                Thumbnail__c = 'thumbnail2',
                                Title__c = 'title2',
                                Selftext__c = 'selftext2',
                                Created__c = 1234));

        insert testData;

        Test.startTest();
        List<reddit_items__c> result = redditItemsHandler.getRedditRecords();
        Test.stopTest();

        system.assertEquals(2, result.size());
    }

    @isTest
    static void testdeteleRedditRecord(){

        reddit_items__c testData = new reddit_items__c(Author_Fullname__c = 'author_fullname',
                                Thumbnail__c = 'thumbnail',
                                Title__c = 'title',
                                Selftext__c = 'selftext',
                                Created__c = 1234);

        insert testData;

        Test.startTest();
        redditItemsHandler.deteleRedditRecord(testData.Id);
        Test.stopTest();

        List<reddit_items__c> deletedRecords = [SELECT Id FROM reddit_items__c];
        system.assertEquals(0, deletedRecords.size());

    }

    @isTest
    static void testdeteleRedditRecord2(){

        reddit_items__c testData = new reddit_items__c(Author_Fullname__c = 'author_fullname',
                                Thumbnail__c = 'thumbnail',
                                Title__c = 'title',
                                Selftext__c = 'selftext',
                                Created__c = 1234);

        insert testData;

        Test.startTest();
        redditItemsHandler.deteleRedditRecord(testData.Thumbnail__c);
        Test.stopTest();

        List<reddit_items__c> deletedRecords = [SELECT Id FROM reddit_items__c];
        system.assertEquals(null, deletedRecords);

    }

}