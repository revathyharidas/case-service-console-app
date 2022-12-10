/**
    * @description : This is a webservice to return the card-charge information associated with a contact
    * @author      : revathyharidas@gmail.com
*/
@RestResource(urlMapping='/v1/card-info/*')
global with sharing class N26DataDisptacher {
   
    /**
    * @description : GET method of the card Info associated with a particular customer
    * 				 This method will fetch the contact using the external id reference (UUID)
    * 				 and query the card charges according to the contact's card product type and country
    */
    @HttpGet
    global static void getCardInfoByContact() {
        final string UUID_REGEX = '^[0-9a-fA-F]{8}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{12}$';      
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;  
        String contactUUID =  RestContext.request.params.get('uuid');
        
        /*Input Validation for UUID*/
        Pattern uuidPattern = Pattern.compile(UUID_REGEX);
        Matcher uuidMatcher = uuidPattern.matcher(contactUUID);
        
        If(!uuidMatcher.matches()){            
            response.responseBody = Blob.valueOf('Invalid Input');
            response.statusCode = 400;
            return;
        }
               
        try{
            List<CardInfo> liInfo = new List<CardInfo>();
            Contact currentCustomer = [SELECT Id, Product__c, Home_Country__c FROM Contact Where External_Contact_Id__c=:contactUUID WITH SECURITY_ENFORCED];
            List<String> productTypes = currentCustomer.Product__c.split(';');
            for(Card_Charge__c cardCharge: [select id, Product__r.Name, Legal_Country__c, ATM_Fee_in_other_currencies__c, Card_Replacement_Cost__c,Cost_per_Calendar_Month__c FROM Card_Charge__c WHERE Product__r.Name IN: productTypes AND Legal_Country__c =:currentCustomer.Home_Country__c WITH SECURITY_ENFORCED]){
                CardInfo card = new CardInfo();
                card.card_type = cardCharge.Product__r.Name;
                card.country = cardCharge.Legal_Country__c;
                card.cost_per_calender_month = cardCharge.Cost_per_Calendar_Month__c;
                card.atm_fee_in_other_currencies = cardCharge.ATM_Fee_in_other_currencies__c;
                card.card_replacement_cost = cardCharge.Card_Replacement_Cost__c;
                liInfo.add(card);
            }
            response.responseBody = Blob.valueOf(JSON.serialize(liInfo));
            response.statusCode = 200;   
        }        
        catch(Exception ex){
            /*psuedo- code to Manage a custom object to store the logs for tracking errors in production 
            * EventLog__c eventLog = new EventLog__c('Error Message','error cause', 'Error component info', 'rest query param info', 'current user info')
            * insert asynchronously
            */
            System.debug(LoggingLevel.ERROR, 'Exception occured in N26DataDisptacher:getCardInfoByContact, Ex: '+ex.getMessage());
            response.responseBody = Blob.valueOf('Exception occured');
            response.statusCode = 500;
        }        
    }    

}