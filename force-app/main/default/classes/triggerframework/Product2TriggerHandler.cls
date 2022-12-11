public class Product2TriggerHandler {

    public class productcardexception extends Exception{}
	
    public static void removeCardCharges(List<Product2> productsDeleted){
        try{
            List<Card_Charge__c> cardChargesTodelete = [SELECT ID From Card_Charge__c WHERE Product__c=:productsDeleted WITH SECURITY_ENFORCED];
            SObjectType sObjectType = Schema.getGlobalDescribe().get('Card_Charge__c');
            if(sObjectType.getDescribe().isDeletable()){
                DELETE cardChargesTodelete;
            }
            else{
                throw new productcardexception('Do not have access to delete!');
            }    
        }
        catch(QueryException ex){
            /*psuedo- code to Manage a custom object to store the logs for tracking errors in production 
            * EventLog__c eventLog = new EventLog__c('Error Message','error cause', 'Error component info', 'current user info')
            * insert asynchronously
            */
            System.debug(LoggingLevel.ERROR, 'Exception occured in Product2TriggerHandler:removeCardCharges, productsDeleted:'+productsDeleted+' , Ex:'+ex.getMessage());
            throw new productcardexception('Deletion of related record failed!');
        }
        catch(DmlException ex){
            /*psuedo- code to Manage a custom object to store the logs for tracking errors in production 
            * EventLog__c eventLog = new EventLog__c('Error Message','error cause', 'Error component info',  'current user info')
            * insert asynchronously
            */
            System.debug(LoggingLevel.ERROR, 'Exception occured in Product2TriggerHandler:removeCardCharges, productsDeleted:'+productsDeleted+' , Ex:'+ex.getMessage());
            throw new productcardexception('Deletion of related record failed!');
        }
    }
}