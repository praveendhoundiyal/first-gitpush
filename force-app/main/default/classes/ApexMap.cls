public class ApexMap {  
    set<id> stid = new set<id>();
        list<string> stringlist = new list<string>();
      map<id,string> accMap = new map<id,string>();
    public static void Maptest() {  
        Map < String, String > studDept = new Map < String, String > ();  
        studDept.put('D01', 'CSE');  
        system.debug(studDept);  
        studDept.put('D02', 'CIVIL');  
        studDept.put('D03', 'MECH');  
        studDept.put('D04', 'EEE');  
        system.debug('get(D01) - Department is: ' + studDept.get('D01'));  
        system.debug('Department keyset() are : ' + studDept.keyset());  
        system.debug('Department values() are : ' + studDept.values());  
        Integer s = studDept.size();  
        system.debug('size() - Department Map Size : ' + s);  
        Map < String, String > studDeptc = studDept.clone();  
        system.debug('clone() - Department values() are : ' + studDeptc.values());  
        studDeptc.clear();  
        system.debug('clear() - Department values() are : ' + studDeptc.values());  
        
    }
    public static void Mapstring(){
        map<string,string> map2 = new map<string,string>
        {
            '1' => 'aa',
            '2' => 'bb',
            '3' => 'cc',
            '4' => 'dd'
        };
            system.debug('======'+map2);
    }
    public void Data(){
       // map<id,string> accMap = new map<id,string>();
        for(Account acc :[Select Id,Name From Account LIMIT 10]){
            accMap.put(acc.id,acc.Name);
        }
        system.debug('Accmap'+accMap);
    }
    public void Data2(){
       // set<id> stid = new set<id>();
       // list<string> stringlist = new list<string>();
        for(Account acc : [Select id,Name From Account LIMIT 10]){
            stid.add(acc.id);
            stringlist.add(acc.Name);
        }
        system.debug('=====sid====='+stid);
        system.debug('==stringlist Name=='+stringlist);
        
    }
    public void Data3(){
        Account acc = new Account();
        acc.AccountNumber ='123456';
        acc.Name = 'Lucifer';
        acc.BillingCity = 'Dehradun';
        acc.BillingPostalCode = '248001';
        insert acc;
        Account acc1 = new Account();
             acc1 =[Select id,name,BillingCity From Account WHERE id =:acc.id];
        acc1.BillingCity = 'DELHI';
        update acc1;
                            
     }
   }