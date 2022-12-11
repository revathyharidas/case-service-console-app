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
### Creating New Product(MasterCard) and Card Charges
![image](https://user-images.githubusercontent.com/11847217/206896586-5d3f1946-f7d6-486e-a12b-1411d096ce55.png)
Added a quick action in Product layout to add card charges
![image](https://user-images.githubusercontent.com/11847217/206896618-814ca41e-1cfe-4ecd-9c05-6b9a94870b3e.png)
![image](https://user-images.githubusercontent.com/11847217/206896688-7572bda2-d20c-4bbc-8ebd-86241cfd3c1c.png)
### The Case Support Agent Experience in Service Console
![image](https://user-images.githubusercontent.com/11847217/206896746-db2c9ad7-8990-43d0-a99b-a99510cda328.png)

## Requirement -2
N26 also uses an external system, where the customer data is shown from Salesforce.The team would need a mechanism to connect to Salesforce and get the relevant
information. External system passes a unique identifier (UUID) that is mapped to every contact record in Salesforce. Design an API that would be able to return the data for a contact based on the table below.

## Solution
Added an External unique identifier in Contact object to store th UUID from the external Service.
![image](https://user-images.githubusercontent.com/11847217/206896924-2dbe1a49-aa81-430d-953f-181411815861.png)

Created a webservice called "N26DataDisptacher" which can be accessed via a connected APP at the resource path 'v1/card-info?uuid='. 
![image](https://user-images.githubusercontent.com/11847217/206897458-473ebdb6-5ad0-4a72-bb0a-82ac23008ee8.png)
### Rest Request - uuid is Required
request.params.put('uuid', contactRecord.External_Contact_Id__c);
### Rest Response - Sample Output
[
    {
        "country": "DE",
        "cost_per_calender_month": "€ 9,90",
        "card_type": "Black",
        "card_replacement_cost": "€ 6",
        "atm_fee_in_other_currencies": "Free"
    },
    {
        "country": "DE",
        "cost_per_calender_month": "€ 0",
        "card_type": "Standard",
        "card_replacement_cost": "€ 6",
        "atm_fee_in_other_currencies": "1.7%"
    },
    {
        "country": "DE",
        "cost_per_calender_month": "€ 16,90",
        "card_type": "Metal",
        "card_replacement_cost": "€ 45",
        "atm_fee_in_other_currencies": "Free"
    }
]

![image](https://user-images.githubusercontent.com/11847217/206897498-60a5f314-d0ec-4bd5-bb62-401d2e6b319b.png)




