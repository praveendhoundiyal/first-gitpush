public class customDataTable {
    
    public class wrapperClass {
        @auraEnabled 
        public List<Account> wrapAccountList {get; set;}
        @auraEnabled   
        public string ErrorList{get; set;}  
        public Integer pageSize {get;set;}
        public Integer pageNumber {get;set;}
        public Integer totalRecords {get;set;}
        public Integer recordStart {get;set;}
        public Integer recordEnd {get;set;}
        public List<Account> accounts {get;set;}
        
    }
    @auraEnabled
    public static string fetchAccounts(Integer pageSize, Integer pageNumber, String sortingField, Boolean isSortAsc){
        system.debug('=pageSize=='+pageSize);
        system.debug('=pageNumber=='+pageNumber);
        system.debug('=sortingField=='+sortingField);
        system.debug('=isSortAsc=='+isSortAsc);
        Integer offset = (pageNumber - 1) * pageSize;
        Integer totalRecords = [SELECT COUNT() FROM Account];
        Integer recordEnd = pageSize * pageNumber;
        String jsonDT = '';
        String sortBy = isSortAsc ? 'ASC' : 'DESC';
        
        String query = 'SELECT Id, Name, AccountNumber, Industry, Phone,Rating FROM Account ORDER BY ';
        query += sortingField + ' ' + sortBy;
        query += ' LIMIT :pageSize OFFSET :offset';
        
        wrapperClass wrap1 = new wrapperClass(); 
        wrap1.pageSize = pageSize;
        wrap1.pageNumber = pageNumber;
        wrap1.recordStart = offset + 1;
        wrap1.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
        wrap1.totalRecords = totalRecords;
        wrap1.accounts = Database.query(query);
        jsonDT = JSON.serialize(wrap1);
        // system.debug('==='+wrap1.initJsonDT);
        return jsonDT;
        
        // return [SELECT Id, Name,Phone, Industry,Praveen__Email__c,Site,AccountNumber, type FROM Account limit 8];
    }
    @auraEnabled
    public static Account EditAccount(string acId){
        account ac= new account();
        if(acId!=null){
            list <Account> acc =  [SELECT Id,Phone, Name, Industry,Praveen__Email__c,
                                   Site,AccountNumber,type,Rating FROM Account where id =:acId];
            if(acc.size()>0){
                ac = acc[0];
            }else{
                ac = new account();
            }
        }
        system.debug('===ac=='+ac);
        return ac;
    }
    @auraEnabled
    public static void UpdateAccount(Account ac, string acid){
        if(acid!=null){
            ac.id = acid;
        }
        update ac;
        //    return [SELECT Id, Name, Industry,Praveen__Email__c,Phone,Site,AccountNumber, type FROM Account ORDER BY name asc];
    }
    @AuraEnabled
    public static List<Account> findByName(String searchKey) {
        list<Account> returnAccount = new list<Account>();
        system.debug('====searchKey===='+searchKey);
        String name =  + searchKey + '%';
        list<Account> findlistAccount = [SELECT id, name, Site,phone,AccountNumber,Industry,type,Rating 
                                         FROM Account WHERE name LIKE :name];
        if(findlistAccount!=null && findlistAccount.size() > 0 ){
            returnAccount = findlistAccount;
        }else{
            returnAccount = new list<Account>();
        }
        system.debug('=returnAccount=='+returnAccount);
        return returnAccount;
    }
    @auraEnabled
    public static wrapperClass delAccRecord (String accid) {
        wrapperClass wrap = new wrapperClass();
        system.debug('==accid==='+accid);
        list <account> deletelist =[SELECT Id  FROM Account where id =:accid];
        list<string> Result = new list<string>();
        Database.deleteResult[] srList = Database.delete(deletelist,false);
        for (Database.deleteResult sr : srList) {
            if (sr.isSuccess()) {
                System.debug('Successfully : ' + sr.getId());
                //   wrap.wrapAccountList = [SELECT Id, Name, Industry,Praveen__Email__c,Phone,Site,
                //     AccountNumber, type FROM Account ORDER BY name asc];  
            } else {
                for(Database.Error objErr : sr.getErrors()) {
                    System.debug('===getStatusCode=== '+objErr.getStatusCode());
                    System.debug (': =====getMessage' + objErr.getMessage());
                    System.debug('field which are affected by the error:'+ objErr.getFields());
                    string getError = string.valueof(objErr.getStatusCode() + ': ' + objErr.getMessage());
                    system.debug('======== ' +getError);
                    wrap.ErrorList = getError;
                    //  wrap.wrapAccountList = [SELECT Id, Name, Industry,Praveen__Email__c,Phone,Site,
                    //    AccountNumber, type FROM Account ORDER BY name asc];  
                }
            }
        }  
        // system.debug('====if error==='+wrap.ErrorList);
        //  system.debug('====else account list==='+wrap.wrapAccountList);
        return wrap;
    }
}