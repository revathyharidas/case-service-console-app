/**
* @description       : Test class for CardInformationController
* @author            : revathyharidas@gmail.com
**/

@isTest
public class CardInformationControllerTest {
    
	/**
    *@description : Method to setup data for the test cases
    */
    @testSetup
    public Static void testDataSetup(){
        /*Inserting test contact record*/ 
        List<Contact> contactsToInsert = new List<Contact>();
        Contact contactRecord = new Contact(FirstName ='Test1', LastName='User', Email = 'test1User@salesforce.com', 
                                            Home_Country__c='FR', Product__c ='Standard;Black',
                                            External_Contact_Id__c='a02529fc-788e-11ed-a1eb-0242ac120002'
                                            );
        contactsToInsert.add(contactRecord);
        contactRecord = new Contact(FirstName ='Test2', LastName='User', Email = 'test2User@salesforce.com', 
                                            Home_Country__c='DE', Product__c ='Metal',
                                            External_Contact_Id__c='a02529fc-788e-11ed-a1eb-0242ac120002'
                                            );
        contactsToInsert.add(contactRecord);
        INSERT contactsToInsert;
       
        /*Inserting card product records*/
        Product2 card1 = new Product2(Name='Standard');
        Product2 card2 = new Product2(Name='Black');
        Product2 card3 = new Product2(Name='Metal');
        List<Product2> productsToInsert = new List<Product2>{card1,card2,card3};
        INSERT productsToInsert;
        
        /*Inserting case records*/
        Case caseRecord = new Case(Status = 'New', Origin = 'Email', Subject = 'Lost credit card', ContactId = contactsToInsert[0].id);
        Case caseRecord1 = new Case(Status = 'New', Origin = 'Phone',  Subject = 'Renew debit card' , ContactId = contactsToInsert[1].id);
        List<Case> casesToInsert = new List<Case>{caseRecord, caseRecord1};
        INSERT casesToInsert;
        
        /*Inserting card charge recs */
        List<Card_Charge__c> cardChargesToInsert = new List<Card_Charge__c>();
        for(Product2 productRec : [SELECT Id, Name FROM Product2 WHERE Name IN ('Standard', 'Black', 'Metal')]){
            Card_Charge__c card = new Card_Charge__c();
            card.Product__c = productRec.Id;
            card.Legal_Country__c = 'FR';
            card.ATM_Fee_in_other_currencies__c = 'Free';
            card.Card_Replacement_Cost__c = '€ 6';
            card.Cost_per_Calendar_Month__c = '€ 9,90';
            cardChargesToInsert.add(card);
            
            card = new Card_Charge__c();
            card.Product__c = productRec.Id;
            card.Legal_Country__c = 'DE';
            card.ATM_Fee_in_other_currencies__c = '1.7%';
            card.Card_Replacement_Cost__c = '€ 6';
            card.Cost_per_Calendar_Month__c = '€ 16,90';
            cardChargesToInsert.add(card);
        }
        
        INSERT cardChargesToInsert;
    }
    
    @isTest static void getCardChargeInfoTest() {
        
    }

}