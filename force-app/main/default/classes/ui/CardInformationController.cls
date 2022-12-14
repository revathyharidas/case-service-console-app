/**
* @description  This is a controller class to provide the card information to display in case layout
* @author       revathyharidas@gmail.com
*/
public with sharing class CardInformationController {
    
    /**
    * @description  This is an apex wired method from the productInformation LWC to retrieve the card charge info
    * @param        caseId : current case record id			 
    */    
    @AuraEnabled(cacheable=true)
    public static List<Card_Charge__c> getCardChargeInfo(Id caseId){
        
        If(String.isBlank(caseId)){
            throw new AuraHandledException('Invalid Input!');
        }
        
        try {
            Contact currentCustomer = [SELECT Id, Product__c, Home_Country__c 
                                       FROM Contact Where Id IN (SELECT ContactId FROM CASE Where Id=: caseId) 
                                       WITH SECURITY_ENFORCED];
            List<String> productTypes = currentCustomer.Product__c.split(';');
            List<Card_Charge__c> cardChargesOfCustomer = [select id, Product__r.Name, Legal_Country__c, toLabel(Legal_Country__c) countryLabel, 
                                                          ATM_Fee_in_other_currencies__c, Card_Replacement_Cost__c, Cost_per_Calendar_Month__c 
                                                          FROM Card_Charge__c WHERE Product__r.Name IN: productTypes 
                                                          AND Legal_Country__c =:currentCustomer.Home_Country__c WITH SECURITY_ENFORCED];        
            return cardChargesOfCustomer; 
            
        } catch (Exception ex) {
            /*psuedo- code to Manage a custom object to store the logs for tracking errors in production 
            * EventLog__c eventLog = new EventLog__c('Error Message','error cause', 'Error component info', 'rest query param info', 'current user info')
            * insert asynchronously
            */
            System.debug(LoggingLevel.ERROR, 'Exception occured in CardInformationController:getCardChargeInfo, caseId:'+caseId+' , Ex:'+ex.getMessage());
            throw new AuraHandledException(ex.getMessage());
        }
    }
}