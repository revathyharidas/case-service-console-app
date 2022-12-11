/**
* @description       : Test class for N26DataDispatcher rest webservice class
* @author            : revathyharidas@gmail.com
**/
@IsTest
public class N26DataDispatcherTest {
    
    /**
    *@description : Method to setup data for the test cases
    */
    @testSetup
    public Static void testDataSetup(){
        
        ID adminProfileId = [Select Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1].Id;
        User adminUser = [select id, UserRoleId from user where id =: UserInfo.getUserId()];
        System.runAs(adminUser){
            CardInfoTestFactory.createCaseCardTestData();
        }
    }
    
    /**
    *@description : positive scenario with valid uuid and card , contact info
    */
    @isTest static void testGetCaseById() {
        User adminUser = [select id, UserRoleId from user where id =: UserInfo.getUserId()];
        System.runAs(adminUser){
            RestRequest request = new RestRequest();
            RestContext.response = new RestResponse();
            request.requestUri = URL.getOrgDomainUrl()+'/services/apexrest/v1/card-info/';
            request.httpMethod = 'GET';
            Contact contactRecord = [SELECT Id, External_Contact_Id__c FROM Contact Limit 1];
            request.params.put('uuid', contactRecord.External_Contact_Id__c);
            RestContext.request = request;       
            RestResponse response = RestContext.response; 
            // Call the method to test
            N26DataDisptacher.getCardInfoByContact();
            System.assertEquals(200,RestContext.response.statusCode);
        }        
    }  
    
    /**
    *@description : negative scenario where no access to records
    */
    @isTest static void testGetCaseById_noAccess() {
        try{
            RestRequest request = new RestRequest();
            RestContext.response = new RestResponse();
            request.requestUri = URL.getOrgDomainUrl()+'/services/apexrest/v1/card-info/';
            request.httpMethod = 'GET';
            Contact contactRecord = [SELECT Id, External_Contact_Id__c FROM Contact Limit 1];
            request.params.put('uuid', '123e4567-e89b-12d3-a456-426655440000');
            RestContext.request = request;       
            RestResponse response = RestContext.response; 
            // Call the method to test
            N26DataDisptacher.getCardInfoByContact();
            System.assertEquals(500,RestContext.response.statusCode);
        }
        Catch(Exception ex){
            system.debug('testGetCaseById_noAccess ex '+ex);
        }               
    } 
    
    /**
    *@description : negative scenario where uuid is invalid
    */
    @isTest static void testGetCaseById_invalidId() {
        User adminUser = [select id, UserRoleId from user where id =: UserInfo.getUserId()];
        System.runAs(adminUser){
            try{
                RestRequest request = new RestRequest();
                RestContext.response = new RestResponse();
                request.requestUri = URL.getOrgDomainUrl()+'/services/apexrest/v1/card-info/';
                request.httpMethod = 'GET';
                Contact contactRecord = [SELECT Id, External_Contact_Id__c FROM Contact Limit 1];
                request.params.put('uuid', 'definitely-not-a-uuid');
                RestContext.request = request;       
                RestResponse response = RestContext.response; 
                // Call the method to test
                N26DataDisptacher.getCardInfoByContact();
                System.assertEquals(400,RestContext.response.statusCode);
            }
            Catch(Exception ex){
                system.debug('testGetCaseById_invalidId ex '+ex);
            } 
        }
    } 
    
}