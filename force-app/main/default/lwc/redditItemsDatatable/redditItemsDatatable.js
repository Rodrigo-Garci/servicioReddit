import { LightningElement, track, wire } from 'lwc';
import { refreshApex } from "@salesforce/apex";
import getRedditRecords from '@salesforce/apex/redditItemsHandler.getRedditRecords';
import deteleRedditRecord from '@salesforce/apex/redditItemsHandler.deteleRedditRecord';

const actions = [
    { label: 'Delete', name: 'Delete'}
];

const columns = [
    { label: 'Title', fieldName: 'Title__c'},
    { label: 'Author Fullname', fieldName: 'Author_Fullname__c'},
    { label: 'Thumbnail', fieldName: 'Thumbnail__c'},
    { label: 'Selftext', fieldName: 'Selftext__c'},
    { label: 'Delete', type:'action', typeAttributes: {rowActions: actions}}
];

export default class RedditItemsDatatable extends LightningElement {

    @track columns = columns;
    @track data;

    redditRecords;
    @wire(getRedditRecords)
        items(response){
            const{error, data} = response;
            this.redditRecords = response;
            if(data){
                this.data = data;
                this.error = undefined;
            }
            else if(error){
                this.error = error;
                this.data = undefined;
            }
        }

    async handleDelete(e){
        var actionName = e.detail.action.name;
        var row = e.detail.row.Id;

        if(actionName = 'Delete'){
            await deteleRedditRecord({ itemId: row });
            refreshApex(this.redditRecords);
        }

    }


}