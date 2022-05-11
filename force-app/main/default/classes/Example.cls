public class Example{
    
      public Example(){
           
            Invoice__c inv = new Invoice__c(Description__c='Test Invoice',
                                      Status__c='Open');
       
            inv.Description__c = 'Test Invoice';
          	ID id = inv.Id;
			String x = inv.Name;
           
          
    }
}