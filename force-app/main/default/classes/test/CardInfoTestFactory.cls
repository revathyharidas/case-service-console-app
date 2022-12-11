/**
* @description       : Test factory class for CardInformationController and N26DatatDispatcher
* @author            : revathyharidas@gmail.com
**/
public class CardInfoTestFactory {

    /*
   * description method to create a test user as custom support profile agent
   */
   public static void createCaseAgent() {
         User agentUser; 
           String agentEmail = 'agentTestUser@salesforce.com';
           String profileId = [SELECT Id FROM Profile WHERE Name ='Custom: Support Profile' LIMIT 1].Id;
           agentUser = new User(
               UserName = agentEmail,
               FirstName = 'Agent',
               LastName = 'Test User',
               Alias = string.valueOf(math.random()).substring(0,4),
               email = agentEmail,   
               ProfileID = profileId,
               TimeZoneSidKey = 'America/New_York',
               LocaleSidKey = 'en_US', 
               EmailEncodingKey = 'UTF-8', 
               LanguageLocaleKey = 'en_US'
           );
           Insert agentUser;
           
           PermissionSet appPermission = [SELECT Id FROM PermissionSet WHERE Name = 'N26CaseStudyApp'];
           
           INSERT new PermissionSetAssignment(
               AssigneeId = agentUser.Id,
               PermissionSetId = appPermission.Id
           );
   }
   
    /*
   * description creating multiple contacts, cases and card product and charge info for test
   */
   public static void createCaseCardTestData() {
        /*Inserting test contact record*/ 
           Contact contactRecord = new Contact(FirstName ='Test1', LastName='User1', Email = 'test1User@salesforce.com', 
                                               Home_Country__c='FR', Product__c ='Standard;Black',
                                               External_Contact_Id__c='a02529fc-788e-11ed-a1eb-0242ac120002'
                                              );
           Contact contactRecord1 = new Contact(FirstName ='Test2', LastName='User2', Email = 'test2User@salesforce.com', 
                                                Home_Country__c='DE', Product__c ='Metal',
                                                External_Contact_Id__c='a02529fc-788e-11ed-a1eb-0242bd120002'
                                               );
           List<Contact> contactsToInsert = new List<Contact>{contactRecord, contactRecord1};
               INSERT contactsToInsert;
           
           /*Inserting product records*/
           Product2 card1 = new Product2(Name='Standard', Family='MasterCard');
           Product2 card2 = new Product2(Name='Black', Family='MasterCard');
           Product2 card3 = new Product2(Name='Metal', Family='MasterCard');
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
   
}