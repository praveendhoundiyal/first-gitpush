public class DemoHelper {
@AuraEnabled
    //return list of accounts from apex class
    //made static so that we dont need to create an instance.Can call using class name
    public static List<Account> checkMethod(){
        List<Account> acclist = [Select Name,Type,Fax,Phone From Account];
        return acclist;
    }
}