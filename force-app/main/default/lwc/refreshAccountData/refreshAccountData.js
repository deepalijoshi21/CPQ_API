import { LightningElement, api } from 'lwc';
import { RefreshEvent } from 'lightning/refresh';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import updateAccountName from '@salesforce/apex/AccountNameRefreshHandler.updateAccountName';

export default class RefreshAccountData extends LightningElement {
    @api recordId;

    async refreshViewHandler(){
        let acc = this.refs.accNameRef.value;
        console.log('Account Input Name == ',acc);
        await updateAccountName ({Id: this.recordId, Name: acc});
        this.showToast();
        this.dispatchEvent(new RefreshEvent());
        console.log('Event is dispatch');
    }

    showToast(){
        const toastEvent = new ShowToastEvent({
            title: "Success!",
            message: "Account Name has been updated successfully.",
            variant: "Success"
        });
        this.dispatchEvent(toastEvent);
        console.log('Show Toast method execute');
    }
}