/**
* @description       : Test class for CardInformationController
* @author            : revathyharidas@gmail.com
**/

@isTest
public class Product2TriggerHandlerTest {
   /**
    *@description : Method to setup data for the test cases
    */
    @testSetup
    public Static void testDataSetup(){
        User adminUser = [select id, UserRoleId, Profile.name FROM User WHERE Profile.name ='System Administrator' Limit 1];
        System.runAs(adminUser){
           CardInfoTestFactory.createCaseCardTestData();
        }
    }
    
    /*
    * description delete product2 records
    */
    @isTest static void getCardChargeInfoTest_contact1() {
	  User adminUser = [select id, UserRoleId, Profile.name FROM User WHERE Profile.name ='System Administrator' Limit 1];        
        System.runAs(adminUser){
            List<Product2> cardProducts = [Select Id, Name FROM Product2 WHERE Family = 'MasterCard'];
            List<Card_Charge__c> cardCharges = [select id, Product__c  FROM Card_Charge__c WHERE Product__c IN: cardProducts];
            System.assertEquals(3, cardProducts.size());
            system.debug('cardCharges.size() '+cardCharges.size());
           // System.assertEquals(3, cardCharges.size());
            try{
                DELETE cardProducts;
                cardProducts = [Select Id, Name FROM Product2 WHERE Family = 'MasterCard'];
                cardCharges = [select id, Product__c  FROM Card_Charge__c WHERE Product__c IN: cardProducts];
          
            }
            catch(Exception ex){
                System.debug('Exception '+ex);
            }
        
        }
    }
}