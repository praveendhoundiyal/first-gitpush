public with sharing class AccountHandler implements ITrigger
{	
    list<opportunity> listopp = new list<opportunity>();
    Map<Id,list<opportunity>> Accmapwithopplist = new Map<Id,list <opportunity>>();//intilize the Accmapwithopplist.
    Map<Id,list<opportunity>> Accmapwith_opplist = new Map<Id,list <opportunity>>();//intilize the Accmapwith_opplist.
    Set<Id> SetAccountId = new Set<Id>();
    // public  map<id,list<opportunity>>mplist = new map<id,list<opportunity>>();
    
    public void bulkBefore()
    {
        list<opportunity>listopp = new list<opportunity>();//initilize the Opprotunity list.
        Set<Id> SetAccountId = new Set<Id>();
        for (sObject so: Trigger.new)
        {
            Account acc = (Account)so;
            SetAccountId.add(acc.Id);//Add accountid in SetAccountId.
        }
        
        // Fetch all the opporunities related to the SetAccountId set.
        for(opportunity opp : [SELECT Id,Account_Address__c,StageName,AccountId FROM opportunity WHERE AccountId IN:SetAccountId])
        {
            // list <opportunity> listopp;
            if(Accmapwith_opplist.containskey(opp.AccountId))
            {
                
                listopp = Accmapwith_opplist.get(opp.AccountId);
                listopp.add(opp);
            }
            
            else
            {
                listopp = new list<opportunity>();
                listopp.add(opp);
            }
            Accmapwith_opplist.put(opp.AccountId,listopp);
            
        }
    }
    
    public void bulkAfter()
    {
        list<opportunity>listopp = new list<opportunity>();//initilize the Opprotunity list.
        Set<Id> SetAccountId = new Set<Id>();
        for (sObject so: Trigger.new)
        {
            Account acc = (Account)so;
            SetAccountId.add(acc.Id);//Add accountid in SetAccountId.
        }
        
        // Fetch all the opporunities related to the SetAccountId set.
        for(opportunity opp : [SELECT Id,Account_Address__c,StageName,AccountId FROM opportunity WHERE AccountId IN:SetAccountId])
        {
            // list <opportunity> listopp;
            if(Accmapwithopplist.containskey(opp.AccountId))
            {
                
                listopp = Accmapwithopplist.get(opp.AccountId);
                listopp.add(opp);
            }
            
            else
            {
                listopp = new list<opportunity>();
                listopp.add(opp);
            }
            Accmapwithopplist.put(opp.AccountId,listopp);
            
        }
        /*  for(opportunity opp:[SELECT id, StageName,AccountId FROM opportunity WHERE AccountId IN:SetAccountId])

{
mplist.put(opp.AccountId,listopp);
system.debug('-----------');
}
system.debug('=====mp======='+mplist);*/
    }
    
    public void beforeInsert(SObject so)
    {
    }
    
    public void beforeUpdate(SObject oldSo, SObject so)
    {
        
        account acc = (account)so;
        account oldacc = (account)oldSo;
        if(oldacc.Status__c!=acc.Status__c){
            if(Accmapwith_opplist.size()>0)
            {
                system.debug('------size----'+Accmapwith_opplist.size());
                if(Accmapwith_opplist.containskey(acc.id))
                {
                    list<opportunity> op = Accmapwith_opplist.get(acc.id);
                    system.debug('------acc-----'+acc.id);
                    system.debug('------op-----'+op);
                    for(opportunity oppor : op)
                    {
                        if(oppor.StageName!='Close Won' && oppor.StageName!='Close Lost')       
                        {
                            acc.addError('Account can not be closed');
                        }
                        else
                            acc.Status__c='closed';
                        
                    }
                }
                
            }
        }
        
    }
    
    public void beforeDelete(SObject so)
    {	
    }
    
    public void afterInsert(SObject so)
    {
    }
    
    public void afterUpdate(SObject oldSo, SObject so)
    {
        account acc = (account)so;
        account oldacc = (account)oldSo;
        
        if(Accmapwithopplist.size()>0){
            if(Accmapwithopplist.containskey(acc.id))
            {
                list<opportunity> listGetopp = Accmapwithopplist.get(acc.id);
                string accAdd=acc.BillingStreet + acc.BillingCity + acc.BillingState + acc.BillingPostalCode + acc.BillingCountry;
                for(opportunity op : listGetopp)
                {
                    op.Account_Address__c = accAdd;
                    listopp.add(op);
                }
            }
            
        }
    }
    public void afterDelete(SObject so)
    {
    }
    
    
    public void andFinally()
    {
        
        
    }
}