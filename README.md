This is a service console app to support case agents while the talk to customers aka contacts.

## Requirement -1 
1. We’re new to Lightning, and starting to make the most of component’s flexibility to show our customer service agents the most important information as, and when, they need it. This might be displaying the customer’s other open issues as they’re talking to them. For this task, we’d like you to display the customer’s product information to the agent whilst they’re interacting. This Lightning component (or Lightning web component, if you prefer) should:
      a. Be visible to the agent on the Case page layout
      b. Use two custom fields (‘Product__c’ and ‘Home_Country__c’) from the related
      Contact record to determine the customer’s product and legal country
      c. Use the values in these fields to display the matching product information
      
The product information to be displayed can be found in the tables given at the end. Each column in the tables below corresponds to a value in the ‘Home_Country__c’ field, and each row relates to a specific ‘Product__c’.Please note that this is subject to change and new factors, such as length of contract or
special packages, could influence any costs and fees. Modifying the existing product information, or adding entirely new products, should be as simple as possible.

## Solution

![image](https://user-images.githubusercontent.com/11847217/206894833-58a7c8ca-8934-4c99-8a3a-60f94be777d3.png)
Description on data model : The type of cards such as Standard, Black and Metal are stored in Product2 standard Object which has product family as "MasterCard". Card_charge__C has a lookup to product2 to identify the product/card.
In Card_Charge__C rest of the information relevant to the mastercards are stored. 
As requirement asks the Contact object has to fields Product__C and Home_Country__c to identify and retrieve the card information.
Instead of a lookup to product2, I have a used a multi picklist to store the products in Contact.

There is Service Console APP has been added called 'N26 Case Study Service Console APP' to cater to the need of case agent's. 
The permission set 'N26CaseStudyApp' need to be assigned to get the necessary object, field, lwc component and apex access!
