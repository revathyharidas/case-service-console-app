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
        
        ID adminProfileId = [Select Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1].Id;
        User adminUser = [select id, UserRoleId from user where id =: UserInfo.getUserId()];
        
        System.runAs(adminUser){
           CardInfoTestFactory.createCaseAgent();
           CardInfoTestFactory.createCaseCardTestData();
        }
    }
    
    /*
    * description positive scenario with first contact who has 1 card product
    */
    @isTest static void getCardChargeInfoTest_contact1() {
        User agentUser = [SELECT Id FROM User WHERE Email ='agentTestUser@salesforce.com'];
        System.runAs(agentUser){
            Case caseRecord = [SELECT Id, Status, Origin, Subject, ContactId FROM Case WHERE Subject = 'Renew debit card'];
            List<Card_Charge__c> charges = CardInformationController.getCardChargeInfo(caseRecord.Id);
            Contact currentCustomer = [SELECT Id, Product__c, Home_Country__c FROM Contact Where Id IN (SELECT ContactId FROM CASE Where Id=: caseRecord.Id)];
            List<String> productTypes = currentCustomer.Product__c.split(';');         
            System.assertEquals(productTypes.size(), charges.size(), 'one card charge info should be returned since the contact has only one products');
            System.assertEquals(currentCustomer.Home_Country__c, charges[0].Legal_Country__c, 'Contact\'s country should match the product charge legal country!');
        }
    }
    
    /*
    * description positive scenario with second contact who has 2 card products
    */
    @isTest static void getCardChargeInfoTest_contact2() {
        User agentUser = [SELECT Id FROM User WHERE Email ='agentTestUser@salesforce.com'];
        System.runAs(agentUser){
            Case caseRecord = [SELECT Id, Status, Origin, Subject, ContactId FROM Case WHERE Subject = 'Lost credit card'];
            List<Card_Charge__c> charges = CardInformationController.getCardChargeInfo(caseRecord.Id);
            Contact currentCustomer = [SELECT Id, Product__c, Home_Country__c FROM Contact Where Id IN (SELECT ContactId FROM CASE Where Id=: caseRecord.Id)];
            List<String> productTypes = currentCustomer.Product__c.split(';');
            System.assertEquals(productTypes.size(), charges.size(), '2 card charge info should be returned since the contact has 2 products!');
            System.assertEquals(currentCustomer.Home_Country__c, charges[0].Legal_Country__c, 'Contact\'s country should match the product charge legal country!');
        }
    }
    
    /*
    * description negative scenario : caseid as null
    */
    @isTest static void getCardChargeInfoTest_ex() {
        User agentUser = [SELECT Id FROM User WHERE Email ='agentTestUser@salesforce.com'];
        System.runAs(agentUser){
            try{
                List<Card_Charge__c> charges = CardInformationController.getCardChargeInfo(null);    
            }
            catch(Exception ex){
                System.assertEquals(ex.getTypeName(), 'System.AuraHandledException');
                System.assertEquals(ex.getMessage(), 'Script-thrown exception');
            }           
        }
    }

	/*
    * description negative scenario: case which has no contact
    */
    @isTest static void getCardChargeInfoTest_invalidCase() {
        User agentUser = [SELECT Id FROM User WHERE Email ='agentTestUser@salesforce.com'];
        System.runAs(agentUser){
            try{
                Case caseRecord = new Case(Status = 'New', Origin = 'Email', Subject = 'Lost credit card', ContactId = null);
                INSERT caseRecord;

                List<Card_Charge__c> charges = CardInformationController.getCardChargeInfo(caseRecord.Id);    
            }
            catch(Exception ex){
                System.assertEquals(ex.getTypeName(), 'System.AuraHandledException');
                System.assertEquals(ex.getMessage(), 'Script-thrown exception');
            }           
        }
    }
    
}
