public class dublicateContact {
    @AuraEnabled
    public static list<contact>  saveContact (string cfname,string clname) {
      
       return [select firstName,LastName from contact where firstName =:cfname AND LastName =:clname];
       /*  if(conlist.size()>0){
            return true;
        }else{
            contact c1 = new contact();
            c1.FirstName = cfname;
            c1.AccountId =cacc;
            c1.LastName =clname;
            c1.Phone =cphne;
            c1.Title=ctitle;
            c1.Email = cemail;
            insert c1;
             return false;
        }*/
        
    }
}