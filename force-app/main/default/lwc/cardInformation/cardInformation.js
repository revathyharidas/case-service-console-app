import { LightningElement, api, wire, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import getCardChargeInfo from '@salesforce/apex/CardInformationController.getCardChargeInfo';

export default class cardInformation extends NavigationMixin(LightningElement) {
@api recordId;
error = '';

@track
chargesOfProducts = [];
@track
hasData = false;
productCharges = [];
title = 'Card Charges In ';

@wire(getCardChargeInfo, { caseId: '$recordId' })
wiredProducts({ error, data }) {
    if (data) {
        if(data.length > 0){
            let recordList = [];
            data.forEach(record => {
            let chargeRec = {
                Product: record.Product__r.Name,
                Country: record.Legal_Country__c,
                CountryLabel: record.countryLabel,
                ATMFee: record.ATM_Fee_in_other_currencies__c,
                CostperMonth: record.Cost_per_Calendar_Month__c,
                replaceMentCost: record.Card_Replacement_Cost__c
            }
                recordList.push(chargeRec);
            });
            this.hasData = true;
            this.title += ` ${recordList[0].CountryLabel} (${recordList[0].Country})`;
            this.productCharges = recordList;
        }else{
            this.error = ' Data not found, please contact your Admin!';
        }  
             
    } else if (error) {  
        /* Log errors 
         */
        this.error = ' You do not have access to view this component, please contact your Admin!';
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