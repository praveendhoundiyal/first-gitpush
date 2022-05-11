public with sharing class EmployeeHandler implements ITrigger
{	 
   
	public EmployeeHandler()
	{
	}

	
	public void bulkBefore()
	{
    }
	
	public void bulkAfter()
	{
	}
		
	public void beforeInsert(SObject so)
	{
      
       Employee_Management__c myEmp = (Employee_Management__c)so;
          system.debug('-----myEmp----'+myEmp);
       if(myEmp.Designation__c=='IT' && myEmp.Salary__c > 50000)
       {
          myEmp.Salary__c =70000;           
       }
        
            
	}
	
	public void beforeUpdate(SObject oldSo, SObject so)
	{
    
	}
    	
	public void beforeDelete(SObject so)
	{	
    }
	
	public void afterInsert(SObject so)
	{
	
    }
	
	public void afterUpdate(SObject oldSo, SObject so)
	{
       
    }


	public void afterDelete(SObject so)
	{
	}
	
	
	public void andFinally()
	{

    }
    

}