public class MapDML_Use {
    public static void fetchAcc(){
       Account acc = [SELECT id,Name from Account where name='MyAccount1'];
       system.debug('========acc======'+acc);
       createRecord(acc);
      deleteRecord(acc);
    }
    public static void createRecord(Account acc){
        system.debug('++++++'+acc);
        List<Contact> conList=new List<Contact>();
        for(integer i=0;i<100;i++){
            Contact con=new Contact();
            con.LastName='contact'+i;
            con.AccountId=acc.Id;
            conList.add(con);
            system.debug('===i==='+i);
        }
        system.debug('===conmap==='+conList.size());
        insert conList;
    }
     public static void deleteRecord(Account acc){
      list<contact> conDel=[SELECT id,AccountId from Contact where AccountId=:acc.Id];
      system.debug('===condel==='+conDel.size());
      delete conDel;
    }
}