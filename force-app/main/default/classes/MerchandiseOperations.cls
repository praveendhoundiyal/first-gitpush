public class MerchandiseOperations {
    public static Id invoice( String pName, Integer pSold, String pDesc) {
// Retrieve the pencils sample merchandise
Merchandise__c m = [SELECT Price__c FROM Merchandise__c WHERE Name = :pName ];
// break if no merchandise is found
System.assertNotEquals(null, m);
// Add a new invoice
Invoice__c i = new Invoice__c(Description__c = pDesc);
insert i;
// Add a new line item to the invoice
Line_Item__c li = new Line_Item__c(Name = '1',Invoice__c = i.Id,Unit_Price__c=m.Price__c, Merchandise__c = m.Id,Quantity__c=5);
insert li;
// Update the inventory of the merchandise item
m.price__c -= pSold;
update m;
return i.Id;
}
}