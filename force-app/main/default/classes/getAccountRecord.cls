public class getAccountRecord {
    @AuraEnabled
    public static list<Account> getAccountRecordMethod(String accNameParamInApex) {
        string accNameKey = '%'+accNameParamInApex+'%';
        list<Account> accList = [select name from account where  name Like: accNameKey];
        return accList;
        
    }
    
}