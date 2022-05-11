@isTest
public class TestDataFactory {
    public static Invoice__c createOneInvoice(Boolean withLineItem) {
// Create one invoice statement
Invoice__c testInvoice = createInvoice();
if (withLineItem == true) {
// Create a merchandise item
Merchandise__c m = createMerchandiseItem('Orange juice');
// Create one line item and associate it with the invoice statement.
AddLineItem(testInvoice, m);
}
return testInvoice;
}
// Helper methods
private static Merchandise__c createMerchandiseItem(String merchName) 
{
Merchandise__c m = new Merchandise__c();
m.Name='test';
m.Inventory__c='500';
m.Price__c=4;
m.Quantity__c=4;
insert m;
return m;
}
private static Invoice__c createInvoice() {
Invoice__c inv = new Invoice__c(Description__c='Test Invoice');
insert inv;
return inv;
}
private static Line_Item__c AddLineItem(Invoice__c inv,Merchandise__c m) {
    Line_Item__c lineItem = new Line_Item__c(Invoice__c = inv.Id,Merchandise__c = m.Id,Unit_Price__c = m.Price__c);
insert lineItem;
return lineItem;
}
}