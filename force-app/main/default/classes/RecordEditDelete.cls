public class RecordEditDelete {
    public list<Employee_Management__c> emp {get;set;}
	 public id deleteRecordid{get;set;}
       public Employee_Management__c recordToDelete;
        public void deleteRecord(){ 
          system.debug('====deleteRecordid=======');
          system.debug('====deleteRecordid======='+deleteRecordid);
          recordToDelete =[SELECT id ,EmployeeName__c,EmployeePhone__c,Address__c,Salary__c,Designation__c FROM Employee_Management__c WHERE Id=: deleteRecordid];
          system.debug('====recordToDelete======='+recordToDelete);
          delete recordToDelete;
    }
}