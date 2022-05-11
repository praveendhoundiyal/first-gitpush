global class InvoiceUtilities {
              static list<Line_Item__c> updatedLineItem = new list<Line_Item__c>();
    
               // Class method to renumber Line Items for a given Invoice number.
               // Returns a string that indicates success or failure.
              webservice static String renumberLineItems(String invoiceName){
                   // Create a copy of the target Invoice object and its Line Items.
                   Invoice__c invoice =
                                       [SELECT Name, (Select Name FROM Line_Items__r ORDER BY Name DESC) 
                                       FROM Invoice__c 
                                       WHERE Name = :invoiceName LIMIT 1];
                  // Loop through each Line Item, re-numbering as you go
                  Integer i = 1;
                   for (Line_Item__c item : invoice.Line_Items__r) {
                      item.Name = String.valueOf(i);
                      System.debug(item.Name);
                      updatedLineItem.add(item);
                      i++; 
                  }
                          
                  
                  
                 // Update the Line Items in one transaction, rollback if any problems.
                // and return error messages to the calling environment.
                try {
                     update updatedLineItem;
                }
                catch (DmlException e) {
                    return e.getMessage();
                }
               // On success, return a message to the calling program
               return 'Line items renumbered successfully.';
              
      } 

}