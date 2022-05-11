public class MapDml{
    public static void CreateRecord  (){
	list <Account> accts = new list<Account>();
    for (Integer a = 0; a <100; a++) {
    Account ac=new Account();
    ac.name='myAccount1';
    accts.add(ac);
  
}
}
 	public static void DeleteRecord(){
	list <Account> Testaccts = [SELECT id, createddate FROM Account WHERE createddate =yesterday];
    system.debug('============Test='+Testaccts.size());  
    delete Testaccts;
        
 }
}