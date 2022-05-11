public class ExampleDML {
    public static void Example(){
        Account acc = new Account();
        acc.Name = 'MyRecord';
        acc.BillingCity = 'Dehradun';
        insert acc;
        
        Account myacc = new Account();
        myacc =[select id,Name,BillingCity from Account Where id =:acc.Id];
        myacc.BillingCity = 'DELHI';
        update myacc;
    }
}