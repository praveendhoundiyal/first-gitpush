public class ContactNewEdit {
    @AuraEnabled
    public static string saveContact (Contact con) {
        system.debug('==='+con);
        insert con;
        system.debug('==='+con.id);
        return con.id;
        
    }
    @AuraEnabled
    public static void UpdateContact (contact con,string contId){
        contact c = new contact();
        if(contId!=null){
            c.id =contId;
        }
        if(con.AccountId!=null){
            c.AccountId =con.AccountId;
        }
        if(con.FirstName!=null){
            c.FirstName =con.FirstName;
        }if(con.LastName!=null){
            c.LastName =con.LastName;
        }if(con.Phone!=null){
            c.Phone =con.Phone;
        }if(con.Title!=null){
            c.Title =con.Title;
        }if(con.Praveen__Salary__c!=null){
            c.Praveen__Salary__c =con.Praveen__Salary__c;
        }if(con.LeadSource!=null){
            c.LeadSource =con.LeadSource;
        }if(con.Praveen__Loan_Amount__c!=null){
            c.Praveen__Loan_Amount__c =con.Praveen__Loan_Amount__c;
        }if(con.Email!=null){
            c.Email =con.Email;
        }
        update c;
    }
    @AuraEnabled
    public static Contact UpdateContactName (string conId){
        contact c =  [select id,accountid,firstname,lastname,Phone,Title,LeadSource,Praveen__Loan_Amount__c,
                      Email from contact where id =:conId];
        system.debug('===c===='+c);
        
        return c;
        
    }
}