public class DataTable {
    @AuraEnabled
    public static list<Account> fetchAccount(Integer pageSize, Integer pageNumber){
        Integer offset = (pageNumber - 1) * pageSize;
        List<Account> accList = new List<Account>();
        accList = [SELECT Id, Name, AccountNumber,Rating, Industry, Phone FROM Account LIMIT :pageSize OFFSET :offset];
        return accList;  
    }
    @AuraEnabled
    public static Account editAccount(string editRecId){
        account ac= new account();
        if(editRecId!=null){
            list <Account> acc =  [SELECT Id,Phone, Name, Industry,Praveen__Email__c,
                                   Site,AccountNumber,type,Rating FROM Account where id =:editRecId];
            if(acc.size()>0){
                ac = acc[0];
            }else{
                ac = new account();
            }
        }
        return ac;
    }
    @auraEnabled
    public static void updateAccountRec(account ac,string acid){
        if(acid!=null){
            ac.id = acid;
        }
        update ac;
    }
    @auraEnabled
    public static void deleteAccountRec(string deleteAccountRecId){
        if(deleteAccountRecId!=null){
            Account deleteAccount =[select id from Account where id=:deleteAccountRecId];
            delete deleteAccount;
        }
    }
    @AuraEnabled
    public static List<Account> findByName(String searchKey) {
        list<Account> returnAccount = new list<Account>();
        String name =  + searchKey + '%';
        list<Account> findlistAccount = [SELECT id, name, phone, Industry, Rating 
                                         FROM Account WHERE name LIKE :name];
        if(findlistAccount!=null && findlistAccount.size() > 0 ){
            returnAccount = findlistAccount;
        }else{
            returnAccount = new list<Account>();
        }
        return returnAccount;
    }
}