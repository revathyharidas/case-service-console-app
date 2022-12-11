trigger product2Trigger on Product2 (before delete) {
    
    if(trigger.isbefore && trigger.isdelete){
         List<Product2> cardProducts = new List<Product2>();
         for(Product2 prod : trigger.old){
             If(prod.Family == 'MasterCard'){
                 cardProducts.add(prod);
             } 
         }
         
         if(cardProducts.size()>0){
             Product2TriggerHandler.removeCardCharges(cardProducts);
         }
    }
    
   }