import { LightningElement, wire, track } from 'lwc';
import { getRecord, updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getQuotes from '@salesforce/apex/QuoteProductSelector.getQuotes';
import getProducts from '@salesforce/apex/QuoteProductSelector.getProducts';
import addProductToQuote from '@salesforce/apex/QuoteProductSelector.addProductToQuote';

export default class QuoteLineItemEditor extends LightningElement {
    @track quoteId;
    @track productId;
    @track quotes;
    @track products;
    @track quantity;

    // Fetch the quotes and products when component is loaded
    connectedCallback() {
        this.loadQuotes();
        this.loadProducts();
    }

    // Fetch the quotes
    loadQuotes() {
        getQuotes()
            .then(result => {
                this.quotes = result.map(record => ({ label: record.Name, value: record.Id }));
                console.log('Quote selected', this.quotes);
            })
            .catch(error => {
                console.error('Error fetching quotes', error);
            });
    }

    // Fetch the products
    loadProducts() {
        getProducts()
            .then(result => {
                this.products = result.map(record => ({ label: record.Name, value: record.Id }));
                console.log('Product selected', this.products);
            })
            .catch(error => {
                console.error('Error fetching products', error);
            });
    }


    // Handle quote selection from custom dropdown
    handleQuoteSelect(event) {
        this.quoteId = event.detail.value;
    }

    // Handle product selection from custom dropdown
    handleProductSelect(event) {
        this.productId = event.detail.value;
    }

    // Handle quantity change
    handleQuantityChange(event) {
        this.quantity = event.target.value;
    }
    
    // Add the selected product to the selected quote
    handleAddProductToQuote() {
        addProductToQuote({ quoteId: this.quoteId, productId: this.productId, quantity: this.quantity })
            .then(() => {
                console.log('Product added to quote');
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Product added to quote',
                        variant: 'success',
                    }),
                );

            })
            .catch(error => {
                console.error('Error adding product to quote', error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error adding product to quote',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            })
            .finally(()=>{
                // Clear the input fields
                this.quoteId = null;
                this.productId = null;
                this.quantity = null;
            })
    }
}
