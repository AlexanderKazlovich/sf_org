import { api, LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';
import { reduceErrors } from 'c/ldsUtils';

export default class AccountList extends LightningElement {
    @api recordId
    
    @wire(getContacts,{recordId:'$recordId'})
    contacts;

    get errors() {
        return (this.contacts.error) ?
            reduceErrors(this.contacts.error) : [];
    }

}