public class opportunityHandler implements ITrigger
{	
    Set<Id> SetAccountId = new Set<Id>();
    public Map<Id,string> mp = new Map<Id,string>();
    public  map<id,Account> countmap = new map<id,Account>();
    public list <Account> acclist = new list<Account>();
    
	public void bulkBefore()
	{
       
        system.debug('-----ddd---');
       if(trigger.isInsert || trigger.isUpdate)
       {
           for(sObject so: Trigger.new)
           {
               system.debug('-------Enter-------');
               Opportunity op = (Opportunity)so;
               SetAccountId.add(op.Id);
            
           }
       }
        
        for(Account acc : [SELECT Id,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry From Account WHERE Id IN:SetAccountId])
        {
            string address  = acc.BillingStreet + acc.BillingCity + acc.BillingState + acc.BillingPostalCode + acc.BillingCountry;
            mp.put(acc.id,address);
        }
     }
	
	public void bulkAfter()
	{
        if(Trigger.isInsert || Trigger.isUpdate){
            for(sObject so: Trigger.new)
            {
                Opportunity op = (Opportunity)so;
               SetAccountId.add(op.AccountId);
            } 
        }
        if(Trigger.isDelete){
            for(sObject so: Trigger.old)
            {
                Opportunity op = (Opportunity)so;
               SetAccountId.add(op.Accountid);
            } 
        }
        for(Account acc:[SELECT id, Opp_Count_Trigger__c  FROM Account WHERE Id IN:SetAccountId])
        {
            countmap.put(acc.id,acc);
        }
       
     }
    
		
	public void beforeInsert(SObject so)
	{
        opportunity opp = (opportunity)so;
        if(opp.Account_Address__c != null){        
            if(mp.size()>0)
            {
                if(mp.containsKey(opp.AccountId))
                {
                    string address=mp.get(opp.AccountId);
                    opp.Account_Address__c = address;
                    
                }
            }
         }
	 }
	
	public void beforeUpdate(SObject oldSo, SObject so)
	{
        opportunity opp = (opportunity)so;
        if(opp.Account_Address__c != null){        
            if(mp.size()>0)
            {
                if(mp.containsKey(opp.AccountId))
                  
                {
                    string address=mp.get(opp.AccountId);
                    opp.Account_Address__c = address;
                    
                }
            }
         }
    }	
	public void beforeDelete(SObject so)
	{	
    }
    
	
	public void afterInsert(SObject so)
	{
        opportunity op = (opportunity)so;
        system.debug('=====countmap===='+countmap.size());
        
        if(countmap.size()>0)
            
        {
            system.debug('==op======'+op.accountid);
            if(countmap.containskey(op.accountid))
            {
                account ac=countmap.get(op.AccountId);
                system.debug('====ac====='+ac);
                if(ac.Opp_Count_Trigger__c==null)
                {
                    ac.Opp_Count_Trigger__c=0;
                }
                ac.Opp_Count_Trigger__c=ac.Opp_Count_Trigger__c+1;
                acclist.add(ac);
            } 
        }
	}
	
	public void afterUpdate(SObject oldSo, SObject so)
	{
		
    }
	public void afterDelete(SObject so)
	{
        opportunity op = (opportunity)so;
        system.debug('-----countmap-----'+countmap.size());
        if(countmap.size()>0)
        {
            if(countmap.containskey(op.accountid))
            {
                account ac=countmap.get(op.AccountId);
                if(ac.Opp_Count_Trigger__c==null)
                {
                    ac.Opp_Count_Trigger__c=0;
                }
                ac.Opp_Count_Trigger__c=ac.Opp_Count_Trigger__c-1;
                acclist.add(ac);
            } 
        }
	}
	
	
	public void andFinally()
	{
        if(acclist.size()>0){
            update accList;
        }
    }
    
}