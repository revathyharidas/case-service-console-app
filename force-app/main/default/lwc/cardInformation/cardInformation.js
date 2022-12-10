import { LightningElement, api, wire, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

import getCardChargeInfo from '@salesforce/apex/CardInformationController.getCardChargeInfo';

export default class cardInformation extends NavigationMixin(LightningElement) {
    @api recordId;
    error = '';

    @track
    chargesOfProducts = [];

    productCharges = [];
    title = 'Card Charges';

    @wire(getCardChargeInfo, { caseId: '$recordId' })
    wiredProducts({ error, data }) {
        if (data) {
            let recordList = [];
            // let customerCountry;
            data.forEach(record => {
                let chargeRec = {
                    Product: record.Product__r.Name,
                    Country: record.Legal_Country__c,
                    ATMFee: record.ATM_Fee_in_other_currencies__c,
                    CostperMonth: record.Cost_per_Calendar_Month__c,
                    replaceMentCost: record.Card_Replacement_Cost__c
                }
                // customerCountry = record.Legal_Country__c;
                recordList.push(chargeRec);
            });

            //this.title += ' ' + customerCountry;
            this.productCharges = recordList;

        } else if (error) {
            console.log('error ', error);
            this.error = error;

        }
    }

    navigateToProductChargeListView(event) {
        event.stopPropagation();

        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Card_Charge__c',
                actionName: 'list'
            },
            state: {
                filterName: 'AllCharges'
            }
        }).then(url => { window.open(url) });
    }

    navigateToProductListView(event) {
        event.stopPropagation();
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Product2',
                actionName: 'list'
            },
            state: {
                filterName: 'AllProducts'
            }
        }).then(url => { window.open(url) });
    }
}